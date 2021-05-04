using HoldingDetails.Models;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Net.Http;
using System.Net.Http.Headers;
using RestSharp;
using RestSharp.Authenticators;
using System.Net;
using Newtonsoft.Json;
using HoldingDetails.BL;
using System.Linq;
using System.Collections.Concurrent;
using System.Threading.Tasks;

namespace HoldingDetails.Controllers
{
    public class HoldingController : Controller
    {
        static string ClientId = System.Web.Configuration.WebConfigurationManager.AppSettings["ClientId"];
        static string Secret = System.Web.Configuration.WebConfigurationManager.AppSettings["Secret"];
        static string ApiUrl = System.Web.Configuration.WebConfigurationManager.AppSettings["ApiUrl"];
        PlaidEntities DB = new PlaidEntities();

        RestHelper helper = new RestHelper(ClientId, Secret, ApiUrl);

        public HoldingController()
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls;

        }



        // GET: Holding
        public ActionResult Holding()
        {
            if (Session["LinkToken"] == null || Session["AccessToken"] == null)
            {
                return RedirectToAction("Connection");
            }

            HoldingResponse holdingResponce = null;
            List<HoldingDetails.Models.Holding> holdingList = null;

            holdingResponce = helper.GetHoldings(Session["AccessToken"].ToString());
            if (holdingResponce != null)
            {
                if (!string.IsNullOrEmpty(holdingResponce.ErrorMessage))
                {
                    TempData["error"] = holdingResponce.ErrorMessage;
                }
                if (holdingResponce.holdings != null)
                {
                    holdingList = holdingResponce.holdings;
                }
            }


            //----------------------------

            // ViewBag.publicToken = Session["PublicToken"];
            ViewBag.ClientId = ClientId;
            ViewBag.Secret = Secret;
            ViewBag.ApiUrl = ApiUrl;
            ViewBag.LinkToken = Session["LinkToken"];
            return View(holdingList);
        }

        public ActionResult Login()
        {
            if (Session["LoginDtl"] != null)
                return RedirectToAction("Connection");
            else
                return Redirect("~/Account/Login.aspx?ReturnUrl=Plaid");
        }
        [HttpPost]
        public ActionResult Login(tblUser loginDtl)
        {
            using (PlaidEntities DB = new PlaidEntities())
            {
                loginDtl = DB.tblUsers.Where(x => x.LoginId == loginDtl.LoginId && x.Password == loginDtl.Password).FirstOrDefault();
                if (loginDtl != null)
                {
                    Session["LoginDtl"] = loginDtl;
                    return RedirectToAction("Connection");
                }

            }
            return View();
        }
        public ActionResult Connection()
        {
            tblUser loginDtl = null;
            if (Session["LoginDtl"] != null)
            {
                loginDtl = (tblUser)Session["LoginDtl"];
            }

            if (Session["LinkToken"] != null)
            {
                ViewBag.LinkToken = Session["LinkToken"];
            }
            else
            {
                LinkTokenResponse linkResponse = null;
                linkResponse = helper.GetLinkToken();
                if (linkResponse != null)
                {
                    ViewBag.LinkToken = linkResponse.LinkToken;
                    Session["LinkToken"] = linkResponse.LinkToken;
                }
            }
            using (PlaidEntities DB = new PlaidEntities())
            {
                var instanceCollection = DB.tblInstances.Where(item => item.UserId == loginDtl.Id).Select(instance => new
                {
                    instance.ConnectionId,
                    instance.InstanceId,
                    instance.InstanceName,
                    AccessToken = instance.AccessToken.Trim()
                }).AsEnumerable().Select(x => new
                {
                    ConnectionId = x.ConnectionId,
                    InstanceId = x.InstanceId,
                    InstanceName = x.InstanceName,
                    AccessToken = Base64Decode(x.AccessToken.ToString())
                });
                if (instanceCollection?.Count() > 0)
                {
                    int index = 0;
                    Task<KeyValuePair<string, List<HoldingDisplay>>>[] concurrentTasks = new Task<KeyValuePair<string, List<HoldingDisplay>>>[instanceCollection.Count()];
                    foreach (var instance in instanceCollection)
                    {
                        concurrentTasks[index] = Task.Run(() => GetHoldingResponse(instance.AccessToken));
                        index++;
                        if (index == instanceCollection.Count())
                        {
                            break;
                        }
                    }
                    try
                    {
                        Task.WaitAll(concurrentTasks);
                        if (concurrentTasks != null)
                        {
                            ConcurrentDictionary<string, List<HoldingDisplay>> allThreadSafeHoldings = new ConcurrentDictionary<string, List<HoldingDisplay>>();
                            Parallel.ForEach(concurrentTasks, (task) =>
                            {
                                if (task != null && task.IsCompleted && !task.IsFaulted && !task.IsCanceled 
                                    && task.Status == TaskStatus.RanToCompletion)
                                {
                                    KeyValuePair<string, List<HoldingDisplay>> keyValuePair = task.Result;
                                    allThreadSafeHoldings.TryAdd(keyValuePair.Key, keyValuePair.Value);
                                }
                            });

                            if (allThreadSafeHoldings?.Count > 0)
                            {
                                List<HoldingDisplayExt> allHoldings = (from eachKeyValuePair in allThreadSafeHoldings
                                                                        where eachKeyValuePair.Value?.Count > 0
                                                                        from value in eachKeyValuePair.Value
                                                                        select new HoldingDisplayExt(value)
                                                                        {
                                                                            ConnectionId = instanceCollection.First(o => o.AccessToken.Equals(eachKeyValuePair.Key)).ConnectionId,
                                                                            InstanceId = instanceCollection.First(o => o.AccessToken.Equals(eachKeyValuePair.Key)).InstanceId,
                                                                            InstanceName = instanceCollection.First(o => o.AccessToken.Equals(eachKeyValuePair.Key)).InstanceName,
                                                                        })
                                                                        .ToList();  

                                ViewBag.ClientId = ClientId;
                                ViewBag.Secret = Secret;
                                ViewBag.ApiUrl = ApiUrl;
                                ViewBag.LinkToken = Session["LinkToken"];
                                ViewBag.InstanceCollection = instanceCollection;
                                return View("holding", allHoldings);

                                //return View("holding", allHoldings.OrderByDescending(o => o.ConnectionId));
                            }
                            else
                            {
                                TempData["error"] = "Error occurred to process all holding data simultaneously.";
                                return View("holding", null);
                            }
                        }
                        else
                        {
                            TempData["error"] = "Error occurred to get all holding data simultaneously.";
                            return View("holding", null);
                        }
                    }
                    catch (System.AggregateException agEx)
                    {
                        if (agEx.InnerExceptions?.Count > 0)
                        {
                            TempData["error"] = agEx.Flatten().Message;
                        }
                        return View("holding", null);
                    }
                    catch (System.Exception ex)
                    {
                        TempData["error"] = ex.Message;
                        return View("holding", null);
                    }
                }
                else
                {
                    TempData["error"] = "No instance(s) found in DB.";
                    return View("holding", null);
                }
            }
        }

        private Task<KeyValuePair<string, List<HoldingDisplay>>> GetHoldingResponse(string accessToken)
        {
            List<HoldingDisplay> holdingDisplayList = null;
            HoldingResponse holdingResponce = helper.GetHoldings(accessToken);
            if (holdingResponce?.holdings?.Count > 0)
            {
                holdingDisplayList = new List<HoldingDisplay>();
                foreach (Holding holding in holdingResponce.holdings)
                {
                    holdingDisplayList.Add(new HoldingDisplay(holding, holdingResponce.accounts, holdingResponce.securities));
                }
            }
            return Task.FromResult(new KeyValuePair<string, List<HoldingDisplay>>(accessToken, holdingDisplayList));
        }


        [HttpPost]
        public ActionResult Connection(string ConnectionDtl, string Action)
        {
            if (Session["LinkToken"] != null)
            {
                ViewBag.LinkToken = Session["LinkToken"];
            }
            if (!string.IsNullOrEmpty(Action) && Session["LoginDtl"] != null)
            {
                ActionClass obj = JsonConvert.DeserializeObject<ActionClass>(Action);
                if (obj.Action.Equals("Go"))
                {
                    using (PlaidEntities DB = new PlaidEntities())
                    {
                        string AccessToken = DB.tblInstances.Where(x => x.ConnectionId == obj.Id).Select(x => x.AccessToken).FirstOrDefault().ToString();
                        Session["AccessToken"] =Base64Decode(AccessToken.Trim());
                        return RedirectToAction("Holding");
                    }
                }
                else if (obj.Action.Equals("Delete"))
                {
                    using (PlaidEntities DB = new PlaidEntities())
                    {
                        tblInstance RemoveInstances = DB.tblInstances.Where(x => x.ConnectionId == obj.Id).Select(x => x).FirstOrDefault();
                        if (RemoveInstances != null)
                        {
                            DB.tblInstances.Remove(RemoveInstances);
                            DB.SaveChanges();
                        }
                        List<tblInstance> Instances = DB.tblInstances.Select(x => x).ToList<tblInstance>();
                        return View(Instances);
                    }
                }
                else if (obj.Action.Equals("Save"))
                {
                    using (PlaidEntities DB = new PlaidEntities())
                    {
                        var result = DB.tblInstances.SingleOrDefault(b => b.ConnectionId == obj.Id);
                        if (result != null)
                        {
                            result.InstanceName = obj.InstanceName;
                            DB.SaveChanges();
                        }
                        //List<tblInstance> Instances = DB.tblInstances.Select(x => x).ToList<tblInstance>();
                        //return View(Instances);
                        RedirectToAction("Connection");
                    }
                }
                else if (obj.Action.Equals("Cancel"))
                {
                    return View();
                }
                else
                    return View();


            }
            else if (!string.IsNullOrEmpty(ConnectionDtl) && Session["LoginDtl"] != null)
            {
                tblInstance obj = JsonConvert.DeserializeObject<tblInstance>(ConnectionDtl);
                PublicTokenExchangeResponse publicTokenEx = helper.GetAccessToken(obj.PublicToken.Trim());
                if (string.IsNullOrEmpty(publicTokenEx.ErrorCode))
                {
                    tblUser loginDtl = (tblUser)Session["LoginDtl"];
                    obj.UserId = loginDtl.Id;
                    obj.AccessToken = Base64Encode(publicTokenEx.AccessToken.Trim());
                    obj.PublicToken = Base64Encode(obj.PublicToken.Trim());
                    using (PlaidEntities DB = new PlaidEntities())
                    {
                        DB.tblInstances.Add(obj);
                        DB.SaveChanges();
                    }
                }
            }

            return RedirectToAction("Connection");
            //using (PlaidEntities DB = new PlaidEntities())
            //{
            //    List<tblInstance> Instances = DB.tblInstances.Select(x => x).ToList<tblInstance>();
            //    return View(Instances);
            //}
        }
        public string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        public string Base64Decode(string base64EncodedData)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }
    }
}

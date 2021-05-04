using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using HoldingDetails.Models;

namespace WebApplication2.Areas.Plaid.Controllers
{
    public class LocalAPIController : ApiController
    {
        // GET: Plaid/API
        public LocalAPIController()
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls;

        }

        [HttpPost]
        [Route("api/LocalAPI/AddToPlaidDB")]
        public String AddToPlaidDB(tblUser obj)
        {
            using (PlaidEntities DB = new PlaidEntities())
            {
                DB.tblUsers.Add(new tblUser { LoginId = obj.LoginId, Password = obj.Password, FName = "", LName = "" });
                DB.SaveChanges();
            }
            return "Success";
        }

        [HttpPost]
        [Route("api/LocalAPI/GetLoginDtlPlaidDB")]
        public tblUser GetLoginDtlPlaidDB(tblUser obj)
        {
            tblUser loginDtl;
            using (PlaidEntities DB = new PlaidEntities())
            {
                loginDtl = DB.tblUsers.Where(x => x.LoginId == obj.LoginId && x.Password == obj.Password).FirstOrDefault();
               

            }
            return loginDtl;
        }
    }
}
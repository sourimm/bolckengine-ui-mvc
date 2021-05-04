using System;
using System.Web;
using System.Web.UI;
using HoldingDetails.BL;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Newtonsoft.Json;
using Owin;
using RestSharp;
using WebApplication2.Models;

namespace WebApplication2.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterHyperLink.NavigateUrl = "Register";
            // Enable this once you have account confirmation enabled for password reset functionality
            //ForgotPasswordHyperLink.NavigateUrl = "Forgot";
            OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];
            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!String.IsNullOrEmpty(returnUrl))
            {
                RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
            }
        }

        protected void LogIn(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // Validate the user password
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                var signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();

                // This doen't count login failures towards account lockout
                // To enable password failures to trigger lockout, change to shouldLockout: true
                var result = signinManager.PasswordSignIn(Email.Text, Password.Text, RememberMe.Checked, shouldLockout: false);

                switch (result)
                {
                    case SignInStatus.Success:

                        String LocalAPI = String.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Headers["host"].ToString(), "/api/LocalAPI/GetLoginDtlPlaidDB");

                        RestHelper helper = new RestHelper("", "", "");
                        HoldingDetails.Models.tblUser obj = new HoldingDetails.Models.tblUser();
                        obj.LoginId = Email.Text;
                        obj.Password = Password.Text;
                        IRestResponse response = helper.RestCall(LocalAPI, obj);
                        if (response.StatusCode.ToString() == "OK")
                        {
                            HoldingDetails.Models.tblUser loginDtl = JsonConvert.DeserializeObject<HoldingDetails.Models.tblUser>(response.Content);
                            Session["LoginDtl"] = loginDtl;
                            IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                        }

                        break;
                    case SignInStatus.LockedOut:
                        Response.Redirect("/Account/Lockout");
                        break;
                    case SignInStatus.RequiresVerification:
                        Response.Redirect(String.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}", 
                                                        Request.QueryString["ReturnUrl"],
                                                        RememberMe.Checked),
                                          true);
                        break;
                    case SignInStatus.Failure:
                    default:
                        FailureText.Text = "Invalid login attempt";
                        ErrorMessage.Visible = true;
                        break;
                }
            }
        }
    }
}
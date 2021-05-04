using HoldingDetails.BL;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using WebApplication2.Models;

namespace WebApplication2.Account
{
    public partial class Register : Page
    {
        
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            String LocalAPI = String.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Headers["host"].ToString(), "/api/LocalAPI/AddToPlaidDB");
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var user = new ApplicationUser() { UserName = Email.Text, Email = Email.Text };
            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                // For more information on how to enable account confirmation and password reset please visit https://go.microsoft.com/fwlink/?LinkID=320771
                //string code = manager.GenerateEmailConfirmationToken(user.Id);
                //string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id, Request);
                //manager.SendEmail(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>.");
                RestHelper helper = new RestHelper("","","");
                HoldingDetails.Models.tblUser obj = new HoldingDetails.Models.tblUser();
                obj.LoginId = Email.Text;
                obj.Password = Password.Text;
                IRestResponse response = helper.RestCall(LocalAPI, obj);
                if (response.StatusCode.ToString() == "OK" && JsonConvert.DeserializeObject<String>(response.Content) == "Success")
                {
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }
    }
   
}
using System.Web.Mvc;

namespace WebApplication2.Areas.Plaid
{
    public class PlaidAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Plaid";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "Plaid_default",
                "Plaid/{controller}/{action}/{id}",
                defaults: new { controller = "Holding", action = "Login", id = UrlParameter.Optional },
                namespaces: new[] { "HoldingDetails.Controllers" }
            );
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class _Default : Page
    {
        String apiUri = "https://auth.tdameritrade.com/auth?response_type=code&redirect_uri=https%3A%2F%2F127.0.0.1&client_id=12345%40AMER.OAUTHAP";
        public Uri Get(string apiUri)
        {
            using (var httpClient = new System.Net.Http.HttpClient())
            {
                var httpResponseMessage = httpClient.GetAsync(apiUri).Result;
                Uri requestUri = httpResponseMessage.RequestMessage.RequestUri;
                System.Diagnostics.Debug.WriteLine(requestUri.AbsoluteUri);
                Console.WriteLine(requestUri.AbsoluteUri);
                return requestUri;
            }
        }
    }
}
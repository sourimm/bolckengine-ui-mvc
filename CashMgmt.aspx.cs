using System;
using System.Web.UI;
using Newtonsoft.Json;
using System.Data;

using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;

using System.Net;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class _CashMgmt : Page
    {
        String accountId;
        String accountCustodian;
        String subAccountId;
        String accessToken;
        private List<object> currentPrices;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void CashMgmtAccountListGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            //accountId = CoinbaseAccountListGridView.SelectedRow.Cells[1].Text;
            //accountCustodian = CoinbaseAccountListGridView.SelectedRow.Cells[2].Text;
            //string walletURL = "https://api.coinbase.com/v2/accounts/";
            //String performanceJSON = retrieveJsonByWebClient(walletURL, getTokenByAccountId(accountId));
            //var dt = JsonConvert.DeserializeObject<Root>(performanceJSON);
            //gvCoinBasePerformance.DataSource = dt.data;
            //gvCoinBasePerformance.DataBind();
        }

        protected void gvCashMgmtPerformance_SelectedIndexChanged(object sender, EventArgs e)
        {
            //subAccountId = gvCoinBasePerformance.SelectedRow.Cells[1].Text;
            //accessToken = getTokenByAccountId(accountId);
            //string transactionURL = "https://api.coinbase.com/v2/accounts/" + subAccountId + "/transactions";
            //String transactionURLByAccountAndCurrency = retrieveJsonByWebClient(transactionURL, getTokenByAccountId(accountId));
            //saveJsonToDatabase(transactionURLByAccountAndCurrency);
        }

        private String retrieveJsonByWebClient(String apiUrl, String token)
        {
            WebClient client = new WebClient();
            client.Headers["Content-type"] = "application/json";
            client.Headers["Authorization"] = "Bearer " + token ;
            client.Encoding = Encoding.UTF8;
            string json = client.DownloadString(apiUrl);
            //gvPerformance.DataSource = (new JavaScriptSerializer()).Deserialize<List<Customer>>(json);
            //gvPerformance.DataBind();
            return json;
        }
    }
}
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
    public partial class _PortfolioCoinbase : Page
    {
        String accountId;
        String accountCustodian;
        String subAccountId;
        String accessToken;
        private List<object> currentPrices;

        protected void Page_Load(object sender, EventArgs e)
        {
            //currentPrices = getCurrentPrices();
        }

        protected void CoinbaseAccountListGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            accountId = CoinbaseAccountListGridView.SelectedRow.Cells[1].Text;
            accountCustodian = CoinbaseAccountListGridView.SelectedRow.Cells[2].Text;
            string walletURL = "https://api.coinbase.com/v2/accounts/";
            String performanceJSON = retrieveJsonByWebClient(walletURL, getTokenByAccountId(accountId));
            var dt = JsonConvert.DeserializeObject<Root>(performanceJSON);
            gvCoinBasePerformance.DataSource = dt.data;
            gvCoinBasePerformance.DataBind();
        }

        protected void gvCoinBasePerformance_SelectedIndexChanged(object sender, EventArgs e)
        {
            subAccountId = gvCoinBasePerformance.SelectedRow.Cells[1].Text;
            accessToken = getTokenByAccountId(accountId);
            string transactionURL = "https://api.coinbase.com/v2/accounts/" + subAccountId + "/transactions";
            String transactionURLByAccountAndCurrency = retrieveJsonByWebClient(transactionURL, getTokenByAccountId(accountId));
            saveJsonToDatabase(transactionURLByAccountAndCurrency);
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

        private List<Prices> getCurrentPrices()
        {
            WebClient client = new WebClient();
            client.Headers["Content-type"] = "application/json";
            client.Encoding = Encoding.UTF8;
            string json = client.DownloadString("https://api.coinbase.com/v2/prices/");
            var data = JsonConvert.DeserializeObject(json);
            List<Prices> prices=null;
            return prices;
        }

        private void saveJsonToDatabase(String json) 
        {
                try
                {
                string strConnection = ConfigurationManager.ConnectionStrings["blockengineConnectionString"].ToString();
                    using (SqlConnection cn = new SqlConnection(strConnection))
                    using (SqlCommand cmd = new SqlCommand("usp_storeTransaction", cn))
                    {
                        if (cn.State == ConnectionState.Closed)
                            cn.Open();
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@inputJson", json);
                        cmd.ExecuteNonQuery();
                    }
                }
                catch (Exception ex)
                {
                }
        }

        private String getTokenByAccountId(String accountId)
        {
            string token="";
            try
            {
                string strConnection = ConfigurationManager.ConnectionStrings["blockengineConnectionString"].ToString();
                using (SqlConnection cn = new SqlConnection(strConnection))
                using (SqlCommand cmd = new SqlCommand("select top 1 token from account where account_id = (@accountid)", cn))
                {
                    if (cn.State == ConnectionState.Closed)
                        cn.Open();
                        cmd.Parameters.AddWithValue("@accountid", accountId);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
            }
            return token;
        }
    }
}
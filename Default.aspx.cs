using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace WebApplication2
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string code = Convert.ToString(Request.QueryString["code"]);
            string state = Convert.ToString(Request.QueryString["state"]);
            if (!string.IsNullOrEmpty(code) && string.IsNullOrEmpty(state))
            {
                string url = string.Format("https://api.tdameritrade.com/v1/oauth2/token");
                RestClient client = new RestClient(url);
                RestRequest postRequest = new RestRequest(Method.POST);
                string urlDecodeCode = Server.UrlDecode(code);
                postRequest.AddHeader("cache-control", "no-cache");
                postRequest.AddHeader("content-type", "application/x-www-form-urlencoded");
                //postRequest.AddParameter("application/x-www-form-urlencoded", "grant_type=authorization_code&access_type=offline&code=" + code + "&client_id=12345@AMER.OAUTHAP&redirect_uri=https://127.0.0.1:44344/ManageAccounts.aspx", ParameterType.RequestBody);
                postRequest.AddParameter("application/x-www-form-urlencoded", "grant_type=authorization_code&access_type=offline&code=" + code + "&client_id=12345@AMER.OAUTHAP&redirect_uri=http://127.0.0.1:44344/ManageAccounts.aspx", ParameterType.RequestBody);
                IRestResponse response = client.Execute(postRequest);
                Session["tdaToken"] = response.Content;
                if (!string.IsNullOrEmpty(response.Content))
                {
                    if (response.ResponseStatus.Equals(RestSharp.ResponseStatus.Completed))
                    {
                        var jObject = Newtonsoft.Json.Linq.JObject.Parse(response.Content);
                        var access_token = jObject.GetValue("access_token");
                        Console.WriteLine("access token to save : " + access_token);
                        if (!string.IsNullOrEmpty((String)access_token))
                        {
                            LoadTokenToDatabase((String)access_token, "emailaddr", "emailaddr", "TDA");
                        }
                      }
                }
            }
            else
            {
                string url = string.Format("https://api.coinbase.com/oauth/token");
                RestClient client = new RestClient(url);
                RestRequest postRequest = new RestRequest(Method.POST);
                postRequest.AddHeader("cache-control", "no-cache");
                postRequest.AddHeader("content-type", "application/x-www-form-urlencoded");
                postRequest.AddParameter("application/x-www-form-urlencoded", "grant_type=authorization_code&code=" + code + "&client_id=67890&client_secret=98765&redirect_uri=https://localhost:44344/ManageAccounts.aspx", ParameterType.RequestBody);
                IRestResponse response = client.Execute(postRequest);
                /* Sample response
                 * {
                    "access_token": "12345",
                    "token_type": "bearer",
                    "expires_in": 7200,
                    "refresh_token": "54321",
                    "scope": "wallet:user:read wallet:accounts:read"
                    }
                */
                //Request.QueryString["code"]
                Session["CoinBasedToken"] = Response;
                if (!string.IsNullOrEmpty(response.Content))
                {
                    if (response.ResponseStatus.Equals(RestSharp.ResponseStatus.Completed))
                    {
                        var jObject = Newtonsoft.Json.Linq.JObject.Parse(response.Content);
                        var access_token = jObject.GetValue("access_token");
                        Console.WriteLine("access token to save : " + access_token);
                        if (!string.IsNullOrEmpty((String) access_token)) {
                        LoadTokenToDatabase((String) access_token, "emailaddr", "emailaddr", "Coinbase");
                        }
                    }
                }
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void LoadTokenToDatabase(String access_token, String name, String email, String custodian)
        {
            //TODO store tokens using always encrypted
            //SqlConnectionStringBuilder strbldr = new SqlConnectionStringBuilder();
            //string dataSource = "Data Source=DB;Initial Catalog=blockengine;Integrated Security = true;";
            //strbldr.DataSource = dataSource;
            //strbldr.ColumnEncryptionSetting = SqlConnectionColumnEncryptionSetting.Enabled;
            //using (SqlConnection con = new SqlConnection(strbldr.ConnectionString))
            string strConnection = ConfigurationManager.ConnectionStrings["blockengineConnectionString"].ToString();
            using (SqlConnection con = new SqlConnection(strConnection))
            {
                try
                {
                    using (var cmd = new SqlCommand("INSERT INTO accounts (account_Id, name, timestamp, token, email, custodian) VALUES (@accountid, @name, getDate(), @access_token, @email, @custodian)"))
                    {
//                        SqlParameter paramToken = cmd.CreateParameter();
//                        paramToken.ParameterName = @"@access_token";
//                        paramToken.DbType = DbType.AnsiStringFixedLength;
//                        paramToken.Direction = ParameterDirection.Input;
//                        paramToken.Value = access_token;
//                        paramToken.Size = access_token.Length;
//                        cmd.Parameters.Add(paramToken);

                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@accountid", "accountid");
                        cmd.Parameters.AddWithValue("@name", email);
                        cmd.Parameters.AddWithValue("@access_token", access_token);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@custodian", custodian);
                        con.Open();
                        Console.WriteLine("Running sql " + cmd.ToString());
                        if (cmd.ExecuteNonQuery() > 0)
                        {
                            //Console.WriteLine("Record inserted");
                            MessageBox.Show("Record inserted");
                        }
                        else
                        {
                            //Console.WriteLine("Record failed");
                            MessageBox.Show("Record failed");
                        }
                    }
                }
                catch (Exception e)
                {
                    //Console.WriteLine("Error during insert: " + e.Message);
                    MessageBox.Show("Error during insert: " + e.Message);
                }
            }
        }
    }
}
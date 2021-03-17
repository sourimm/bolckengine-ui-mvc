using System;
using System.Web.UI;
using Newtonsoft.Json;
using System.Data;

using System.Collections.Generic;
using System.Web;
using System.Web.UI.WebControls;

using System.Net;
using System.Text;
using System.Web.Script.Serialization;

namespace WebApplication2
{
    public partial class _PortfolioTDA : Page
    {
        String accountId;
        String accountCustodian;

        protected void AccountListGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            accountId = AccountListGridView.SelectedRow.Cells[1].Text;
            accountCustodian = AccountListGridView.SelectedRow.Cells[2].Text;
 //       }
 //       protected void Page_Load(object sender, EventArgs e)
  //      {

            string performanceURL = "http://localhost:8080/blockengine/performance/external/" + accountId;
            string accountURL = "http://localhost:8080/blockengine/accounts";
            string modelURL = "http://localhost:8080/blockengine/models";

            //            String JSONAccount3 = PopulateGridView(performanceURL);
            //            JSONAccount3 = JSONAccount3.Replace("\"", "'");
            //            JSONAccount3 = "[" + JSONAccount3 + "]";

            String JSONAccount1 = PopulateGridView(accountURL);
            JSONAccount1 = JSONAccount1.Replace("\"", "'");
            //JSONAccount1 = "[" + JSONAccount1 + "]";

            String JSONAccount2 = PopulateGridView(modelURL);
            JSONAccount2 = JSONAccount2.Replace("\"", "'");
            //JSONAccount2 = "[" + JSONAccount2 + "]";

            String performanceJSON = PopulateGridView(performanceURL);
            performanceJSON = performanceJSON.Replace("\"", "'");
            //performanceJSON = "[" + performanceJSON + "]";

            //Using DataTable with JsonConvert.DeserializeObject, here you need to import using System.Data;  
            DataTable myObjectDT1 = JsonConvert.DeserializeObject<DataTable>(JSONAccount1);

            //Binding gridview from dynamic object   
            GridView1.DataSource = myObjectDT1;
            GridView1.DataBind();

            DataTable myObjectDT2 = JsonConvert.DeserializeObject<DataTable>(JSONAccount2);   
            GridView2.DataSource = myObjectDT2;
            GridView2.DataBind();

            DataTable myObjectDT3 = JsonConvert.DeserializeObject<DataTable>(performanceJSON);  
            gvPerformance.DataSource = myObjectDT3;
            gvPerformance.DataBind();

        }
        private String PopulateGridView(String apiUrl)
        {
            WebClient client = new WebClient();
            client.Headers["Content-type"] = "application/json";
            client.Encoding = Encoding.UTF8;
            string json = client.DownloadString(apiUrl);
            //gvPerformance.DataSource = (new JavaScriptSerializer()).Deserialize<List<Customer>>(json);
            //gvPerformance.DataBind();
            return json;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication2
{
    // Root myDeserializedClass = JsonConvert.DeserializeObject<Root>(myJsonResponse); 
    public class Pagination
    {
        public object ending_before { get; set; }
        public object starting_after { get; set; }
        public object previous_ending_before { get; set; }
        public string next_starting_after { get; set; }
        public int limit { get; set; }
        public string order { get; set; }
        public object previous_uri { get; set; }
        public string next_uri { get; set; }
    }

    public class Balance
    {
        public string amount { get; set; }
        public string currency { get; set; }
    }

    public class NativeBalance
    {
        public string amount { get; set; }
        public string currency { get; set; }
    }

    public class Rewards
    {
        public string apy { get; set; }
        public string formatted_apy { get; set; }
        public string label { get; set; }
    }

    public class Datum
    {
        public string id { get; set; }
        public string name { get; set; }
        public bool primary { get; set; }
        public string type { get; set; }
        public string currency { get; set; }
        public Balance balance { get; set; }
        public DateTime created_at { get; set; }
        public DateTime updated_at { get; set; }
        public string resource { get; set; }
        public string resource_path { get; set; }
        public bool allow_deposits { get; set; }
        public bool allow_withdrawals { get; set; }
        public NativeBalance native_balance { get; set; }
        public Rewards rewards { get; set; }
        public string rewards_apy { get; set; }
    }

    public class Warning
    {
        public string id { get; set; }
        public string message { get; set; }
        public string url { get; set; }
    }

    public class Root
    {
        public Pagination pagination { get; set; }
        public List<Datum> data { get; set; }
        public List<Warning> warnings { get; set; }
    }

    public class Prices
    {
        public List<Datum> data { get; set; }
    }
}
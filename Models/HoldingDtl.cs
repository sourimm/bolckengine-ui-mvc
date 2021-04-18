using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace HoldingDetails.Models
{
    public class ActionClass : tblInstance
    {
        public int Id { get; set; }
        public String Action { get; set; }
    }
    public class HoldingResponse
    {
        [JsonProperty("request_id")]
        public string RequestId { get; set; }

        [JsonProperty("error_code")]
        public string ErrorCode { get; set; }

        [JsonProperty("error_message")]
        public string ErrorMessage { get; set; }

        public List<Holding> holdings = new List<Holding>();

        public List<Account> accounts = new List<Account>();

        public List<Security> securities = new List<Security>();
    }

    public sealed class HoldingDisplayExt : HoldingDisplay
    {
        public int ConnectionId { get; set; }
        public string InstanceId { get; set; }
        public string InstanceName { get; set; }

        public HoldingDisplayExt(HoldingDisplay holdingDisplay)
        {
            this.Symbol = holdingDisplay.Symbol;
            this.Account = holdingDisplay.Account;
            this.Cost_Share = holdingDisplay.Cost_Share;
            this.Qty = holdingDisplay.Qty;
            this.Asset = holdingDisplay.Asset;
            this.Price = holdingDisplay.Price;
            this.MktValue = holdingDisplay.MktValue;
            this.DayGainDollar = holdingDisplay.DayGainDollar;
            this.DayGainPercentage = holdingDisplay.DayGainPercentage;
            this.GainDollar = holdingDisplay.GainDollar;
            this.GainPercentage = holdingDisplay.GainPercentage;
        }
    }

    public class HoldingDisplay
    {
        public HoldingDisplay() { }
        public HoldingDisplay(Holding holding, List<Account> accounts, List<Security> securities)
        {
            if (securities?.Count > 0 && securities.Any(o => o.SecurityId.Equals(holding.SecurityId)))
            {
                var securityObject = securities.First(o => o.SecurityId.Equals(holding.SecurityId));
                Symbol = securityObject.TickerSymbol;
                Asset = securityObject.Type;
            }
            if (accounts?.Count > 0 && accounts.Any(o => o.AccountId.Equals(holding.AccountId)))
            {
                var accountObject = accounts.First(o => o.AccountId.Equals(holding.AccountId));
                Account = accountObject.Name;
            }
            Cost_Share = holding.CostBasis;
            Qty = holding.Quantity;
            Price = holding.InstitutionPrice;
            MktValue = holding.InstitutionValue;
        }

        public string Symbol { get; protected set; }
        public string Account { get; protected set; }
        public float? Cost_Share { get; protected set; }
        public float? Qty { get; protected set; }
        public string Asset { get; protected set; }
        public float? Price { get; protected set; }
        public float? MktValue {get; protected set; }
        public string DayGainDollar { get; protected set; }
        public string DayGainPercentage { get; protected set; }
        public string GainDollar { get; protected set; }
        public string GainPercentage { get; protected set; }
    }

    public class Account
    {
        [JsonProperty("account_id")]
        public string AccountId { get; set; }

        [JsonProperty("mask")]
        public string Mask { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("official_name")]
        public string OfficialName { get; set; }

        [JsonProperty("subtype")]
        public string SubType { get; set; }

        [JsonProperty("Type")]
        public string type { get; set; }
    }

    public class Security
    {
        [JsonProperty("close_price")]
        public double? ClosePrice { get; set; }

        [JsonProperty("close_price_as_of")]
        public object ClosePriceAsOf { get; set; }

        [JsonProperty("cusip")]
        public object Cusip { get; set; }

        [JsonProperty("institution_id")]
        public object InstitutionId { get; set; }

        [JsonProperty("institution_security_id")]
        public object InstitutionSecurityId { get; set; }

        [JsonProperty("is_cash_equivalent")]
        public bool IsCashEquivalent { get; set; }

        [JsonProperty("isin")]
        public object Isin { get; set; }

        [JsonProperty("iso_currency_code")]
        public string IsoCurrencyCode { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("proxy_security_id")]
        public object ProxySecurityId { get; set; }

        [JsonProperty("security_id")]
        public string SecurityId { get; set; }

        [JsonProperty("sedol")]
        public object Sedol { get; set; }

        [JsonProperty("ticker_symbol")]
        public string TickerSymbol { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("unofficial_currency_code")]
        public object UnofficialCurrencyCode { get; set; }
    }

    public class Holding
    {
        [JsonProperty("account_id")]
        public string AccountId { get; set; }
        [JsonProperty("cost_basis")]
        public float CostBasis { get; set; }
        [JsonProperty("institution_price")]
        public float InstitutionPrice { get; set; }
        [JsonProperty("institution_price_as_of")]
        public string InstitutionPriceAsOf { get; set; }
        [JsonProperty("institution_value")]
        public float InstitutionValue { get; set; }
        [JsonProperty("iso_currency_code")]
        public string IsoCurrencyCode { get; set; }
        [JsonProperty("quantity")]
        public float Quantity { get; set; }
        [JsonProperty("security_id")]
        public string SecurityId { get; set; }
        [JsonProperty("unofficial_currency_code")]
        public string UnofficialCurrencyCode { get; set; }
    }
    public class PublicTokenParam
    {
        [JsonProperty("client_id")]
        public string ClientId { get; set; }

        [JsonProperty("secret")]
        public string Secret { get; set; }
        [JsonProperty("institution_id")]
        public string InstitutionId { get; set; }

        [JsonProperty("initial_products")]
        public string[] InitialProducts { get; set; }
    }

    public class PublicTokenResponse
    {
        [JsonProperty("public_token")]
        public string PublicToken { get; set; }

        [JsonProperty("request_id")]
        public string RequestId { get; set; }
    }

    public class PublicTokenExchangeParam
    {
        [JsonProperty("public_token")]
        public string PublicToken { get; set; }

        [JsonProperty("client_id")]
        public string ClientId { get; set; }

        [JsonProperty("secret")]
        public string Secret { get; set; }
    }

    public class PublicTokenExchangeResponse
    {
        [JsonProperty("access_token")]
        public string AccessToken { get; set; }

        [JsonProperty("item_id")]
        public string ItemId { get; set; }

        [JsonProperty("request_id")]
        public string RequestId { get; set; }
        [JsonProperty("error_code")]
        public string ErrorCode { get; set; }

        [JsonProperty("error_message")]
        public string ErrorMessage { get; set; }
    }

    public class HoldingReqParam
    {
        [JsonProperty("access_token")]
        public string AccessToken { get; set; }

        [JsonProperty("client_id")]
        public string ClientId { get; set; }

        [JsonProperty("secret")]
        public string Secret { get; set; }
    }

    public class LinkTokenParam
    {
        [JsonProperty("client_id")]
        public string ClientId { get; set; }

        [JsonProperty("secret")]
        public string Secret { get; set; }

        [JsonProperty("client_name")]
        public string ClientName { get; set; }

        [JsonProperty("products")]
        public string[] Products { get; set; }

        [JsonProperty("country_codes")]
        public string[] CountryCodes { get; set; }

        [JsonProperty("language")]
        public string Language { get; set; }

        [JsonProperty("user")]
        public User User { get; set; }
    }

    public class LinkTokenResponse
    {
        [JsonProperty("link_token")]
        public string LinkToken { get; set; }

        [JsonProperty("request_id")]
        public string RequestId { get; set; }
    }

    public class User
    {
        [JsonProperty("client_user_id")]
        public string ClientUserId { get; set; }
    }


}

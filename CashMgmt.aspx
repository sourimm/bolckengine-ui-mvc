<%@ Page Title="Cash Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CashMgmt.aspx.cs" Inherits="WebApplication2._CashMgmt"%>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    table{
        border-collapse: separate;
        /*border-spacing: 5px;*/ /* Apply cell spacing */
    }
    table, th, td{
        border: 1px solid lightblue;
    }
    table th, table td{
        padding: 10px; /* Apply cell padding */
    }
        .auto-style1 {
            font-family: Arial;
            font-size: medium;
        }
        .auto-style2 {
            font-family: Arial;
            font-weight: bold;
            font-size: medium;
        }
    </style>
       <h2>Coinbase Accounts</h2>
    <table class="nav-justified" style="border:hidden;">
        <tr>
            <td>
                <span class="auto-style2">Your Accounts</span>
                <asp:GridView ID="CoinbaseAccountListGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="CoinbaseAccountListDataSource" CellPadding="4" ForeColor="#333333" GridLines="None" CellSpacing="2" OnSelectedIndexChanged="CoinbaseAccountListGridView_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="account_id" HeaderText="Account" SortExpression="account_id" ItemStyle-CssClass="hiddencol"  HeaderStyle-CssClass="hiddencol">
<HeaderStyle CssClass="hiddencol"></HeaderStyle>

<ItemStyle CssClass="hiddencol"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="custodian" HeaderText="Custodian" SortExpression="custodian" />
                        <asp:ButtonField ButtonType="Button" HeaderText="Performance" Text="Calculate" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" BorderWidth="4px" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                </td>
            <td>&nbsp;

                <span class="auto-style1"><strong>Cost Basis</strong></span><asp:GridView ID="GridViewResults" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" DataSourceID="CostBasisDataSource" AllowSorting="True">
        <AlternatingRowStyle BackColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="CoinbaseAccountListDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:blockengineConnectionString %>" SelectCommand="SELECT [account_id], [custodian] FROM [accounts] where custodian = 'coinbase'">
                </asp:SqlDataSource>
            </td>
            <td>
            <asp:SqlDataSource ID="CostBasisDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:blockengineConnectionString %>" SelectCommand="select currency, sum(amount) as SumQuantity, sum(native_amount) as SumAmount, 
            sum(native_amount)/sum(amount) as AverageCost
            from transactions where type = 'buy'
            group by currency">
            </asp:SqlDataSource>
            </td>
        </tr>
    </table>
            <br />
    <span class="auto-style1"><strong>Holdings and Performance</strong></span><br />
&nbsp;<asp:GridView ID="gvCoinBasePerformance" runat="server" CellPadding="4" AutoGenerateColumns="false" ForeColor="#333333" GridLines="None" AllowSorting="True" OnSelectedIndexChanged="gvCoinBasePerformance_SelectedIndexChanged">
        <Columns>
        <asp:CommandField ShowSelectButton="True" />
        <asp:BoundField DataField="id" HeaderText="ID" />
        <asp:BoundField DataField="name" HeaderText="Name" />
        <asp:BoundField DataField="primary" HeaderText="Primary" />
        <asp:BoundField DataField="type" HeaderText="Type" />
        <asp:BoundField DataField="currency" HeaderText="Currency" />
        <asp:BoundField DataField="balance.amount" HeaderText="Amount" />
        <asp:BoundField DataField="balance.currency" HeaderText="Currency" />
        <asp:BoundField DataField="created_at" HeaderText="Created Date" />
        <asp:BoundField DataField="updated_at" HeaderText="Updated Date" />
        <asp:BoundField DataField="resource" HeaderText="Resource" />
        <asp:BoundField DataField="resource_path" HeaderText="Path" />
        <asp:BoundField DataField="allow_deposits" HeaderText="IsDepositAllow" />
        <asp:BoundField DataField="allow_withdrawals" HeaderText="IsWithdrawalAllow" />
        <asp:BoundField DataField="native_balance.amount" HeaderText="Native Amount" />
        <asp:BoundField DataField="native_balance.currency" HeaderText="Native Currency" />
        </Columns>
        <AlternatingRowStyle BackColor="White" />
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>

</asp:Content>

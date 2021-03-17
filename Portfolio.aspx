<%@ Page Title="Portfolio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Portfolio.aspx.cs" Inherits="WebApplication2._Portfolio"%>

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
</style>
            <h2>Portfolio</h2>
            <p>View your accounts</p>

    <br />
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="BlockEngineAccounts" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowEditButton="True" Visible="False" />
                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" Visible="False" />
                    <asp:BoundField DataField="account_id" HeaderText="Account" SortExpression="account_id" Visible="False" />
                    <asp:BoundField DataField="first_name" HeaderText="First Name" SortExpression="first_name" />
                    <asp:BoundField DataField="last_name" HeaderText="Last Name" SortExpression="last_name" />
                    <asp:BoundField DataField="last_edited_timestamp" HeaderText="Last Edited" SortExpression="last_edited_timestamp" />
                    <asp:BoundField DataField="name" HeaderText="Account Nickname" SortExpression="name" />
                    <asp:BoundField DataField="timestamp" HeaderText="Report Date" SortExpression="timestamp" />
                    <asp:TemplateField HeaderText="username" SortExpression="username" Visible="False">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("username") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            *
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="password" SortExpression="password" Visible="False">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("password") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            *
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="token" SortExpression="token" Visible="False">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("token") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            *
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" Visible="False" />
                </Columns>
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
            <asp:SqlDataSource ID="BlockEngineAccounts" runat="server" ConnectionString="<%$ ConnectionStrings:blockengineConnectionString %>" DeleteCommand="DELETE FROM [accounts] WHERE [id] = @id" InsertCommand="INSERT INTO [accounts] ([account_id], [first_name], [last_edited_timestamp], [last_name], [name], [timestamp], [username], [password], [token], [email]) VALUES (@account_id, @first_name, @last_edited_timestamp, @last_name, @name, @timestamp, @username, @password, @token, @email)" SelectCommand="SELECT * FROM [accounts] ORDER BY [name]" UpdateCommand="UPDATE [accounts] SET [account_id] = @account_id, [first_name] = @first_name, [last_edited_timestamp] = @last_edited_timestamp, [last_name] = @last_name, [name] = @name, [timestamp] = @timestamp, [username] = @username, [password] = @password, [token] = @token, [email] = @email WHERE [id] = @id">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int64" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="account_id" Type="Int64" />
                    <asp:Parameter Name="first_name" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="last_edited_timestamp" />
                    <asp:Parameter Name="last_name" Type="String" />
                    <asp:Parameter Name="name" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="timestamp" />
                    <asp:Parameter Name="username" Type="String" />
                    <asp:Parameter Name="password" Type="String" />
                    <asp:Parameter Name="token" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="account_id" Type="Int64" />
                    <asp:Parameter Name="first_name" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="last_edited_timestamp" />
                    <asp:Parameter Name="last_name" Type="String" />
                    <asp:Parameter Name="name" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="timestamp" />
                    <asp:Parameter Name="username" Type="String" />
                    <asp:Parameter Name="password" Type="String" />
                    <asp:Parameter Name="token" Type="String" />
                    <asp:Parameter Name="email" Type="String" />
                    <asp:Parameter Name="id" Type="Int64" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Refresh" />
    <br />
            <br />
            <asp:GridView ID="YourPortfolio" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="BlockEngineTaxLots" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowEditButton="True" Visible="False" />
                    <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" Visible="False" />
                    <asp:BoundField DataField="entity_name" HeaderText="Security" SortExpression="entity_name" />
                    <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" />
                    <asp:BoundField DataField="amount" HeaderText="Amount" SortExpression="amount" />
                    <asp:BoundField DataField="purchase_date" HeaderText="Purchase Date" SortExpression="purchase_date" />
                    <asp:BoundField DataField="last_edited_timestamp" HeaderText="AsOf" SortExpression="last_edited_timestamp" />
                    <asp:BoundField DataField="tax_lot_id" HeaderText="TaxLotId" SortExpression="tax_lot_id" />
                    <asp:BoundField DataField="taxlot" HeaderText="TaxLot" SortExpression="taxlot" />
                    <asp:BoundField DataField="timestamp" HeaderText="timestamp" SortExpression="timestamp" Visible="False" />
                    <asp:BoundField DataField="account_id" HeaderText="account_id" SortExpression="account_id" Visible="False" />
                </Columns>
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
            <asp:SqlDataSource ID="BlockEngineTaxLots" runat="server" ConnectionString="<%$ ConnectionStrings:blockengineConnectionString %>" DeleteCommand="DELETE FROM [taxlots] WHERE [id] = @id" InsertCommand="INSERT INTO [taxlots] ([amount], [entity_name], [last_edited_timestamp], [purchase_date], [quantity], [tax_lot_id], [taxlot], [timestamp], [account_id]) VALUES (@amount, @entity_name, @last_edited_timestamp, @purchase_date, @quantity, @tax_lot_id, @taxlot, @timestamp, @account_id)" SelectCommand="SELECT * FROM [taxlots] ORDER BY [entity_name]" UpdateCommand="UPDATE [taxlots] SET [amount] = @amount, [entity_name] = @entity_name, [last_edited_timestamp] = @last_edited_timestamp, [purchase_date] = @purchase_date, [quantity] = @quantity, [tax_lot_id] = @tax_lot_id, [taxlot] = @taxlot, [timestamp] = @timestamp, [account_id] = @account_id WHERE [id] = @id">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int64" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="amount" Type="Int64" />
                    <asp:Parameter Name="entity_name" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="last_edited_timestamp" />
                    <asp:Parameter DbType="DateTime2" Name="purchase_date" />
                    <asp:Parameter Name="quantity" Type="Int64" />
                    <asp:Parameter Name="tax_lot_id" Type="Int64" />
                    <asp:Parameter Name="taxlot" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="timestamp" />
                    <asp:Parameter Name="account_id" Type="Int64" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="amount" Type="Int64" />
                    <asp:Parameter Name="entity_name" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="last_edited_timestamp" />
                    <asp:Parameter DbType="DateTime2" Name="purchase_date" />
                    <asp:Parameter Name="quantity" Type="Int64" />
                    <asp:Parameter Name="tax_lot_id" Type="Int64" />
                    <asp:Parameter Name="taxlot" Type="String" />
                    <asp:Parameter DbType="DateTime2" Name="timestamp" />
                    <asp:Parameter Name="account_id" Type="Int64" />
                    <asp:Parameter Name="id" Type="Int64" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <br />

</asp:Content>

<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageAccounts.aspx.cs" Inherits="WebApplication2._Default" %>

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
    <div class="row">
        <div class="col-md-4">
            <h2>Manage Accounts</h2>
            <p>Add your accounts</p>
            <%= String.Format("{0}, {1}", "Welcome", HttpContext.Current.User.Identity.Name)%>
            <%: Context.User.Identity.GetUserName()  %>!
            
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="Accounts" CellPadding="4" ForeColor="#333333" GridLines="None" CellSpacing="2">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" Visible="False" />
                        <asp:TemplateField HeaderText="Account Nickname" SortExpression="name">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" Visible="False" />
                        <%--
                        <asp:BoundField DataField="account_id" HeaderText="Account" SortExpression="account_id" />
                        --%>
                        <asp:TemplateField HeaderText="Account" SortExpression="account_id">
                            <EditItemTemplate>
                                <asp:Label ID="AccountId_GridView1" runat="server" Text='<%# Bind("account_id") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                *
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="custodian" HeaderText="Custodian" SortExpression="custodian" />
                        <asp:BoundField DataField="first_name" HeaderText="First Name" SortExpression="first_name" Visible="False" />
                        <asp:BoundField DataField="last_name" HeaderText="Last Name" SortExpression="last_name" Visible="False" />
                        <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" Visible="False" />
                        <asp:TemplateField HeaderText="Token" SortExpression="token">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("token") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                *
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="timestamp" HeaderText="Creation Date" SortExpression="timestamp" />
                        <asp:BoundField DataField="last_edited_timestamp" HeaderText="Last Edited" SortExpression="last_edited_timestamp" />
                        <asp:BoundField DataField="username" HeaderText="Username" SortExpression="username" Visible="False" />
                        <asp:BoundField DataField="password" HeaderText="Password" SortExpression="password" Visible="False" />
                        <asp:ButtonField ButtonType="Button" Text="Check/Update" />
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
                <asp:SqlDataSource ID="Accounts" runat="server" ConnectionString="<%$ ConnectionStrings:blockengineConnectionString %>" SelectCommand="SELECT [id], [account_id], [first_name], [last_edited_timestamp], [last_name], [name], [timestamp], [username], [password], [token], [email], [custodian] FROM [accounts] WHERE ([email] = @email)">
                    <SelectParameters>
                        <asp:SessionParameter Name="email" SessionField="HttpContext.Current.User.Identity.Name" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            <br />
            <p>Edit your Account Details</p>

                <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True" AutoGenerateRows="False" CellPadding="4" DataKeyNames="id" DataSourceID="AccountsInsert" ForeColor="#333333" GridLines="None" Height="50px" Width="125px">
                    <AlternatingRowStyle BackColor="White" />
                    <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                    <EditRowStyle BackColor="#2461BF" />
                    <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
                    <Fields>
                        <%--
                        <asp:BoundField DataField="token" HeaderText="token" SortExpression="token" />
                        --%>
                        <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" Visible="False" />
                        <asp:BoundField DataField="name" HeaderText="Account Nickname" SortExpression="name" />
                        <asp:BoundField DataField="account_id" HeaderText="Account Id" SortExpression="account_id" />
                        <%--
                        <asp:TemplateField HeaderText="Account" SortExpression="account_id">
                            <EditItemTemplate>
                                <asp:Label ID="AccountId_DetailsForm" runat="server" Text='<%# Bind("account_id") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                *
                            </ItemTemplate>
                        </asp:TemplateField>
                        --%>
                        <asp:BoundField DataField="first_name" HeaderText="First Name" SortExpression="first_name" Visible="False" />
                        <asp:BoundField DataField="last_name" HeaderText="Last Name" SortExpression="last_name" Visible="False" />
                        <asp:TemplateField HeaderText="Token" SortExpression="token">
                            <EditItemTemplate>
                                <asp:Label ID="Token_DetailsForm" runat="server" Text='<%# Bind("token") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                *
                            </ItemTemplate>
                            <ItemStyle Width="30px" />
                        </asp:TemplateField> 
                        <asp:BoundField DataField="last_edited_timestamp" HeaderText="Last Edited" SortExpression="last_edited_timestamp" Visible="False" />
                        <asp:BoundField DataField="timestamp" HeaderText="timestamp" SortExpression="timestamp" Visible="False" />
                        <asp:BoundField DataField="username" HeaderText="username" SortExpression="username" Visible="False" />
                        <asp:BoundField DataField="password" HeaderText="password" SortExpression="password" Visible="False" />
                            <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" Visible="False" />
                        <asp:BoundField DataField="custodian" HeaderText="custodian" SortExpression="custodian" Visible="False" />
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                    </Fields>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                </asp:DetailsView>
                <asp:SqlDataSource ID="AccountsInsert" runat="server" ConnectionString="<%$ ConnectionStrings:blockengineConnectionString %>" DeleteCommand="DELETE FROM [accounts] WHERE [id] = @id" InsertCommand="INSERT INTO [accounts] ([account_id], [first_name], [last_edited_timestamp], [last_name], [name], [timestamp], [username], [password], [token], [email], [custodian]) VALUES (@account_id, @first_name, getdate(), @last_name, @name, getdate(), @username, @password, @token, @email, 'TDA')" SelectCommand="SELECT [id], [account_id], [first_name], [last_edited_timestamp], [last_name], [name], [timestamp], [username], [password], [token], [email], [custodian] FROM [accounts]" UpdateCommand="UPDATE [accounts] SET [account_id] = @account_id, [last_edited_timestamp] = getdate(), [name] = @name, [timestamp] = getdate(), [username] = @username, [password] = @password, [token] = @token, [email] = @email, [custodian] = @custodian WHERE [id] = @id">
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
                        <asp:Parameter Name="custodian" Type="String" />
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
                        <asp:Parameter Name="custodian" Type="String" />
                        <asp:Parameter Name="id" Type="Int64" />
                    </UpdateParameters>
                </asp:SqlDataSource>

            <h2>Create Token</h2>
            <p>
                Click button below to generate token for TD Ameritrade</p>
            <p>
                <!--
                <a class="btn btn-default" href="https://auth.tdameritrade.com/auth?response_type=code&redirect_uri=http%3A%2F%2F127.0.0.1:44344&client_id=12345%40AMER.OAUTHAP
                -->
                <!--
                <a class="btn btn-default" href="https://auth.tdameritrade.com/auth?response_type=code&redirect_uri=http%3A%2F%2F127.0.0.1:44344/ManageAccounts&client_id=12345%40AMER.OAUTHAP
">Generate TD Ameritrade Token &raquo;</a>
                -->
                <a class="btn btn-default" href="https://auth.tdameritrade.com/auth?response_type=code&redirect_uri=http://localhost:44344/ManageAccounts&client_id=12345%40AMER.OAUTHAP
">Generate TD Ameritrade Token &raquo;</a>
            </p>

            <p>
                Click button below to generate token for Coinbase</p>
            <p>
                <a class="btn btn-default" href="https://www.coinbase.com/oauth/authorize?response_type=code&client_id=67890&redirect_uri=https://localhost:44344/ManageAccounts.aspx&state=SECURE_RANDOM&account=all&scope=wallet:accounts:read,wallet:transactions:read,wallet:user:read
                
">Generate Coinbase Token &raquo;</a>
            </p>

                        <h2>Manage Profile</h2>
            <p>
                Update account settings</p>
            <p>
                <a class="btn btn-default" href="Account/Manage">Account Profile &raquo;</a>
            </p>
    </div>

    </div>
</asp:Content>

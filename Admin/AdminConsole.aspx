<%@ Page Title="AdminConsole" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminConsole.aspx.cs" Inherits="WebApplication2.Admin.AdminConsole" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Admin Console</h1>
    <h2>Users
    </h2>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="SqlDataSource2" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:CheckBoxField DataField="EmailConfirmed" HeaderText="EmailConfirmed" SortExpression="EmailConfirmed" />
                <asp:BoundField DataField="PasswordHash" HeaderText="PasswordHash" SortExpression="PasswordHash" />
                <asp:BoundField DataField="SecurityStamp" HeaderText="SecurityStamp" SortExpression="SecurityStamp" />
                <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" SortExpression="PhoneNumber" />
                <asp:CheckBoxField DataField="PhoneNumberConfirmed" HeaderText="PhoneNumberConfirmed" SortExpression="PhoneNumberConfirmed" />
                <asp:CheckBoxField DataField="TwoFactorEnabled" HeaderText="TwoFactorEnabled" SortExpression="TwoFactorEnabled" />
                <asp:BoundField DataField="LockoutEndDateUtc" HeaderText="LockoutEndDateUtc" SortExpression="LockoutEndDateUtc" />
                <asp:CheckBoxField DataField="LockoutEnabled" HeaderText="LockoutEnabled" SortExpression="LockoutEnabled" />
                <asp:BoundField DataField="AccessFailedCount" HeaderText="AccessFailedCount" SortExpression="AccessFailedCount" />
                <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [AspNetUsers] WHERE [Id] = @Id" InsertCommand="INSERT INTO [AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (@Id, @Email, @EmailConfirmed, @PasswordHash, @SecurityStamp, @PhoneNumber, @PhoneNumberConfirmed, @TwoFactorEnabled, @LockoutEndDateUtc, @LockoutEnabled, @AccessFailedCount, @UserName)" SelectCommand="SELECT * FROM [AspNetUsers]" UpdateCommand="UPDATE [AspNetUsers] SET [Email] = @Email, [EmailConfirmed] = @EmailConfirmed, [PasswordHash] = @PasswordHash, [SecurityStamp] = @SecurityStamp, [PhoneNumber] = @PhoneNumber, [PhoneNumberConfirmed] = @PhoneNumberConfirmed, [TwoFactorEnabled] = @TwoFactorEnabled, [LockoutEndDateUtc] = @LockoutEndDateUtc, [LockoutEnabled] = @LockoutEnabled, [AccessFailedCount] = @AccessFailedCount, [UserName] = @UserName WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Id" Type="String" />
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="EmailConfirmed" Type="Boolean" />
                <asp:Parameter Name="PasswordHash" Type="String" />
                <asp:Parameter Name="SecurityStamp" Type="String" />
                <asp:Parameter Name="PhoneNumber" Type="String" />
                <asp:Parameter Name="PhoneNumberConfirmed" Type="Boolean" />
                <asp:Parameter Name="TwoFactorEnabled" Type="Boolean" />
                <asp:Parameter Name="LockoutEndDateUtc" Type="DateTime" />
                <asp:Parameter Name="LockoutEnabled" Type="Boolean" />
                <asp:Parameter Name="AccessFailedCount" Type="Int32" />
                <asp:Parameter Name="UserName" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Email" Type="String" />
                <asp:Parameter Name="EmailConfirmed" Type="Boolean" />
                <asp:Parameter Name="PasswordHash" Type="String" />
                <asp:Parameter Name="SecurityStamp" Type="String" />
                <asp:Parameter Name="PhoneNumber" Type="String" />
                <asp:Parameter Name="PhoneNumberConfirmed" Type="Boolean" />
                <asp:Parameter Name="TwoFactorEnabled" Type="Boolean" />
                <asp:Parameter Name="LockoutEndDateUtc" Type="DateTime" />
                <asp:Parameter Name="LockoutEnabled" Type="Boolean" />
                <asp:Parameter Name="AccessFailedCount" Type="Int32" />
                <asp:Parameter Name="UserName" Type="String" />
                <asp:Parameter Name="Id" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <h2>Roles
        </h2>
        <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="UserId,RoleId" DataSourceID="Roles" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" />
                <asp:BoundField DataField="UserId" HeaderText="UserId" ReadOnly="True" SortExpression="UserId" />
                <asp:BoundField DataField="RoleId" HeaderText="RoleId" ReadOnly="True" SortExpression="RoleId" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="Roles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [AspNetUserRoles] WHERE [UserId] = @UserId AND [RoleId] = @RoleId" InsertCommand="INSERT INTO [AspNetUserRoles] ([UserId], [RoleId]) VALUES (@UserId, @RoleId)" SelectCommand="SELECT * FROM [AspNetUserRoles]">
            <DeleteParameters>
                <asp:Parameter Name="UserId" Type="String" />
                <asp:Parameter Name="RoleId" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserId" Type="String" />
                <asp:Parameter Name="RoleId" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <h2>Logins
        </h2>
        <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="LoginProvider,ProviderKey,UserId" DataSourceID="Logins" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" />
                <asp:BoundField DataField="LoginProvider" HeaderText="LoginProvider" ReadOnly="True" SortExpression="LoginProvider" />
                <asp:BoundField DataField="ProviderKey" HeaderText="ProviderKey" ReadOnly="True" SortExpression="ProviderKey" />
                <asp:BoundField DataField="UserId" HeaderText="UserId" ReadOnly="True" SortExpression="UserId" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="Logins" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [AspNetUserLogins] WHERE [LoginProvider] = @LoginProvider AND [ProviderKey] = @ProviderKey AND [UserId] = @UserId" InsertCommand="INSERT INTO [AspNetUserLogins] ([LoginProvider], [ProviderKey], [UserId]) VALUES (@LoginProvider, @ProviderKey, @UserId)" SelectCommand="SELECT * FROM [AspNetUserLogins]">
            <DeleteParameters>
                <asp:Parameter Name="LoginProvider" Type="String" />
                <asp:Parameter Name="ProviderKey" Type="String" />
                <asp:Parameter Name="UserId" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="LoginProvider" Type="String" />
                <asp:Parameter Name="ProviderKey" Type="String" />
                <asp:Parameter Name="UserId" Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
        <h2>ASPNetRoles
        </h2>
        <asp:GridView ID="GridView4" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="AppRoles" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="AppRoles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [AspNetRoles] WHERE [Id] = @Id" InsertCommand="INSERT INTO [AspNetRoles] ([Id], [Name]) VALUES (@Id, @Name)" SelectCommand="SELECT * FROM [AspNetRoles]" UpdateCommand="UPDATE [AspNetRoles] SET [Name] = @Name WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Id" Type="String" />
                <asp:Parameter Name="Name" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" Type="String" />
                <asp:Parameter Name="Id" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <h2>Claims
        </h2>
        <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="Claims" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="UserId" HeaderText="UserId" SortExpression="UserId" />
                <asp:BoundField DataField="ClaimType" HeaderText="ClaimType" SortExpression="ClaimType" />
                <asp:BoundField DataField="ClaimValue" HeaderText="ClaimValue" SortExpression="ClaimValue" />
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
        <asp:SqlDataSource ID="Claims" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [AspNetUserClaims] WHERE [Id] = @Id" InsertCommand="INSERT INTO [AspNetUserClaims] ([UserId], [ClaimType], [ClaimValue]) VALUES (@UserId, @ClaimType, @ClaimValue)" SelectCommand="SELECT * FROM [AspNetUserClaims]" UpdateCommand="UPDATE [AspNetUserClaims] SET [UserId] = @UserId, [ClaimType] = @ClaimType, [ClaimValue] = @ClaimValue WHERE [Id] = @Id">
            <DeleteParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="UserId" Type="String" />
                <asp:Parameter Name="ClaimType" Type="String" />
                <asp:Parameter Name="ClaimValue" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="UserId" Type="String" />
                <asp:Parameter Name="ClaimType" Type="String" />
                <asp:Parameter Name="ClaimValue" Type="String" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />

</asp:Content>

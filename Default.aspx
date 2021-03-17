<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="background-color: mediumseagreen;">
        <h1>Accounts.me</h1>
        <p class="lead">Accounts.me analyzes your portfolio and provides additional financial metrics to help you be a better investor</p>
        <p><a href="PortfolioTDA.aspx" class="btn btn-primary btn-lg">Analyze Portfolio &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <h2>Manage Accounts</h2>
            <p>
                Manage your accounts
            </p>
            <p>
                <a class="btn btn-default" href="ManageAccounts.aspx">Your Accounts &raquo;</a>
            </p>
        </div>
        <div class="col-md-4">
            <h2>Account Profile</h2>
            <p>
                Update your account details
            </p>
            <p>
                <a class="btn btn-default" href="Account/Manage">Your Profile &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>

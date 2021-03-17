<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateToken.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="col-md-4">
            <p>
                &nbsp;</p>
            <h2>Create Token</h2>
            <p>
                Click button below to generate token for TD Ameritrade</p>

                        <p>
                <a class="btn btn-default" href="https://auth.tdameritrade.com/auth?response_type=code&redirect_uri=https%3A%2F%2F127.0.0.1&client_id=12345%40AMER.OAUTHAP
">Generate Token &raquo;</a>
            </p>
            <p>
                &nbsp;</p>
            <p>
                Log into TD Ameritrade with your UserId and Password</p>

            <p>
                <img src="Resources/images/mytdaaccount.png" style="width: 748px; height: 641px" /></p>
            <p>
                Select Allow</p>
            <p>
                <img src="Resources/images/tda_authorizing.png" style="width: 753px; height: 560px" /></p>
    </div>

    </div>
    <p>
        You&#39;re all set!&nbsp; You should see the token stored in your account.</p>
<br />

</asp:Content>

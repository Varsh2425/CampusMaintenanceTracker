<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Register.aspx.vb" Inherits="Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Create Account - Campus Maintenance Tracker</title>

    <style type="text/css">

        body
        {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f4f6f8;
        }

        .header
        {
            background-color: #1f2937;
            color: #ffffff;
            padding: 25px 35px;
        }

        .header-title
        {
            font-size: 34px;
            font-weight: bold;
        }

        .header-subtitle
        {
            font-size: 19px;
            margin-top: 8px;
        }

        .container
        {
            width: 100%;
            padding-top: 45px;
            padding-bottom: 45px;
        }

        .register-card
        {
            width: 460px;
            margin-left: auto;
            margin-right: auto;
            background-color: #ffffff;
            border: 1px solid #d8dde3;
            padding: 35px 40px;
        }

        .title
        {
            text-align: center;
            font-size: 29px;
            font-weight: bold;
            color: #111827;
            margin-bottom: 8px;
        }

        .description
        {
            text-align: center;
            color: #666666;
            font-size: 15px;
            margin-bottom: 30px;
        }

        .field
        {
            margin-bottom: 18px;
        }

        .label
        {
            display: block;
            font-size: 16px;
            font-weight: bold;
            color: #374151;
            margin-bottom: 7px;
        }

        .input
        {
            width: 100%;
            padding: 11px;
            border: 1px solid #aeb6bf;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 15px;
        }

        .register-button
        {
            width: 100%;
            background-color: #263238;
            color: #ffffff;
            border: none;
            padding: 13px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 5px;
        }

        .message
        {
            display: block;
            text-align: center;
            margin-top: 18px;
            font-weight: bold;
            font-size: 14px;
        }

        .login-link
        {
            text-align: center;
            margin-top: 25px;
            font-size: 15px;
            color: #555555;
        }

        .login-link a
        {
            color: #263238;
            font-weight: bold;
            text-decoration: none;
        }

        .login-link a:hover
        {
            text-decoration: underline;
        }

        .note
        {
            background-color: #f1f3f4;
            border-left: 4px solid #263238;
            padding: 12px;
            margin-top: 22px;
            font-size: 13px;
            color: #555555;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="header">

        <div class="header-title">
            Campus Maintenance Tracker
        </div>

        <div class="header-subtitle">
            Create Account
        </div>

    </div>


    <div class="container">

        <div class="register-card">

            <div class="title">
                Create Account
            </div>

            <div class="description">
                Register to submit and track campus maintenance requests.
            </div>


            <div class="field">

                <asp:Label
                    ID="lblNameText"
                    runat="server"
                    CssClass="label"
                    AssociatedControlID="txtName">
                    Full Name
                </asp:Label>

                <asp:TextBox
                    ID="txtName"
                    runat="server"
                    CssClass="input"
                    MaxLength="100">
                </asp:TextBox>

            </div>


            <div class="field">

                <asp:Label
                    ID="lblEmailText"
                    runat="server"
                    CssClass="label"
                    AssociatedControlID="txtEmail">
                    Email
                </asp:Label>

                <asp:TextBox
                    ID="txtEmail"
                    runat="server"
                    CssClass="input"
                    MaxLength="100">
                </asp:TextBox>

            </div>


            <div class="field">

                <asp:Label
                    ID="lblPasswordText"
                    runat="server"
                    CssClass="label"
                    AssociatedControlID="txtPassword">
                    Password
                </asp:Label>

                <asp:TextBox
                    ID="txtPassword"
                    runat="server"
                    CssClass="input"
                    TextMode="Password"
                    MaxLength="100">
                </asp:TextBox>

            </div>


            <div class="field">

                <asp:Label
                    ID="lblContactText"
                    runat="server"
                    CssClass="label"
                    AssociatedControlID="txtContact">
                    Contact Number
                </asp:Label>

                <asp:TextBox
                    ID="txtContact"
                    runat="server"
                    CssClass="input"
                    MaxLength="20">
                </asp:TextBox>

            </div>


            <asp:Button
                ID="btnRegister"
                runat="server"
                Text="CREATE ACCOUNT"
                CssClass="register-button"
                OnClick="btnRegister_Click" />


            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>


            <div class="note">

                New accounts are registered as campus users and
                can submit maintenance requests.

            </div>


            <div class="login-link">

                Already have an account?

                <a href="Login.aspx">
                    Login here
                </a>

            </div>

        </div>

    </div>

</form>

</body>

</html>
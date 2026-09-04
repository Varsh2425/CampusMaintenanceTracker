<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Campus Maintenance Tracker - Login</title>

    <style type="text/css">

        body
        {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f4f6f8;
        }

        .page-header
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

        .main-container
        {
            width: 100%;
            padding-top: 55px;
            padding-bottom: 55px;
        }

        .login-container
        {
            width: 460px;
            margin-left: auto;
            margin-right: auto;
            background-color: #ffffff;
            border: 1px solid #d8dde3;
            padding: 35px;
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
            margin-bottom: 7px;
            font-size: 16px;
            font-weight: bold;
            color: #374151;
        }

        .input
        {
            width: 438px;
            padding: 11px;
            border: 1px solid #aeb6bf;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 15px;
        }

        .login-button
        {
            width: 460px;
            margin-top: 7px;
            padding: 13px;
            background-color: #263238;
            color: #ffffff;
            border: none;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        .login-button:hover
        {
            background-color: #455a64;
        }

        .message
        {
            display: block;
            margin-top: 18px;
            text-align: center;
            font-weight: bold;
            font-size: 14px;
        }

        .register-section
        {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
            color: #555555;
            font-size: 15px;
        }

        .register-link
        {
            color: #263238;
            font-weight: bold;
            text-decoration: none;
            margin-left: 5px;
        }

        .register-link:hover
        {
            text-decoration: underline;
        }

        .info-box
        {
            background-color: #f1f3f4;
            border-left: 4px solid #263238;
            padding: 12px;
            margin-top: 22px;
            color: #555555;
            font-size: 13px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <!-- Page Header -->

    <div class="page-header">

        <div class="header-title">
            Campus Maintenance Tracker
        </div>

        <div class="header-subtitle">
            Login
        </div>

    </div>


    <!-- Main Content -->

    <div class="main-container">

        <div class="login-container">

            <div class="title">
                Welcome Back
            </div>

            <div class="description">
                Login to access your Campus Maintenance Tracker account.
            </div>


            <!-- Email -->

            <div class="field">

                <asp:Label
                    ID="lblEmail"
                    runat="server"
                    Text="Email"
                    CssClass="label">
                </asp:Label>

                <asp:TextBox
                    ID="txtEmail"
                    runat="server"
                    CssClass="input"
                    MaxLength="100">
                </asp:TextBox>

            </div>


            <!-- Password -->

            <div class="field">

                <asp:Label
                    ID="lblPassword"
                    runat="server"
                    Text="Password"
                    CssClass="label">
                </asp:Label>

                <asp:TextBox
                    ID="txtPassword"
                    runat="server"
                    TextMode="Password"
                    CssClass="input"
                    MaxLength="100">
                </asp:TextBox>

            </div>


            <!-- Login Button -->

            <asp:Button
                ID="btnLogin"
                runat="server"
                Text="LOGIN"
                CssClass="login-button"
                OnClick="btnLogin_Click">
            </asp:Button>


            <!-- Login Message -->

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>


            <!-- Register Link -->

            <div class="register-section">

                New user?

                <a
                    href="Register.aspx"
                    class="register-link">
                    Register here
                </a>

            </div>


            <!-- Information -->

            <div class="info-box">

                Use your registered email address and password
                to access the maintenance tracking system.

            </div>

        </div>

    </div>

</form>

</body>

</html>
<%@ Page Language="VB" CodeFile="Profile.aspx.vb" Inherits="User_Profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>My Profile - Campus Maintenance Tracker</title>

    <style type="text/css">

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f4f6f8;
        }

        .header {
            background-color: #1f2937;
            color: white;
            padding: 25px 32px;
            position: relative;
        }

        .header-title {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .header-subtitle {
            font-size: 22px;
        }

        .nav {
            position: absolute;
            right: 32px;
            top: 65px;
        }

        .nav a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            margin-left: 28px;
        }

        .nav a:hover {
            text-decoration: underline;
        }

        .container {
            width: 90%;
            margin: 40px auto;
        }

        .profile-card {
            background-color: white;
            border: 1px solid #d8dde3;
            padding: 35px;
            max-width: 850px;
            margin: 0 auto;
        }

        .profile-title {
            font-size: 30px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #111827;
        }

        .profile-description {
            font-size: 17px;
            color: #555;
            margin-bottom: 30px;
        }

        .profile-row {
            display: flex;
            border-bottom: 1px solid #e5e7eb;
            padding: 18px 5px;
        }

        .profile-label {
            width: 180px;
            font-weight: bold;
            color: #374151;
            font-size: 17px;
        }

        .profile-value {
            color: #111827;
            font-size: 17px;
        }

        .message {
            display: block;
            margin-top: 20px;
            font-weight: bold;
        }

        .back-button {
            display: inline-block;
            margin-top: 30px;
            background-color: #263238;
            color: white;
            text-decoration: none;
            padding: 11px 20px;
            font-size: 16px;
        }

        .back-button:hover {
            background-color: #455a64;
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
            My Profile
        </div>

        <div class="nav">

            <asp:HyperLink
                ID="lnkDashboard"
                runat="server"
                NavigateUrl="~/User/UserDashboard.aspx">
                Dashboard
            </asp:HyperLink>

            <asp:HyperLink
                ID="lnkRequests"
                runat="server"
                NavigateUrl="~/User/MyRequests.aspx">
                My Requests
            </asp:HyperLink>

            <asp:HyperLink
                ID="lnkLogout"
                runat="server"
                NavigateUrl="~/Logout.aspx">
                Logout
            </asp:HyperLink>

        </div>

    </div>


    <div class="container">

        <div class="profile-card">

            <div class="profile-title">
                My Profile
            </div>

            <div class="profile-description">
                View your account information.
            </div>


            <div class="profile-row">

                <div class="profile-label">
                    Name
                </div>

                <div class="profile-value">

                    <asp:Label
                        ID="lblName"
                        runat="server">
                    </asp:Label>

                </div>

            </div>


            <div class="profile-row">

                <div class="profile-label">
                    Email
                </div>

                <div class="profile-value">

                    <asp:Label
                        ID="lblEmail"
                        runat="server">
                    </asp:Label>

                </div>

            </div>


            <div class="profile-row">

                <div class="profile-label">
                    Contact
                </div>

                <div class="profile-value">

                    <asp:Label
                        ID="lblContact"
                        runat="server">
                    </asp:Label>

                </div>

            </div>


            <div class="profile-row">

                <div class="profile-label">
                    Account Type
                </div>

                <div class="profile-value">

                    <asp:Label
                        ID="lblRole"
                        runat="server">
                    </asp:Label>

                </div>

            </div>


            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>


            <asp:HyperLink
                ID="lnkBack"
                runat="server"
                NavigateUrl="~/User/UserDashboard.aspx"
                CssClass="back-button">
                Back to Dashboard
            </asp:HyperLink>

        </div>

    </div>

</form>

</body>

</html>
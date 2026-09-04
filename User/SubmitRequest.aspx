<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SubmitRequest.aspx.vb" Inherits="User_SubmitRequest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Submit Maintenance Request</title>

    <style type="text/css">

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f4f6f8;
        }

        .header {
            background-color: #1f2937;
            color: white;
            padding: 20px;
        }

        .header h1 {
            margin: 0;
        }

        .header a {
            float: right;
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }

        .container {
            width: 70%;
            margin: 30px auto;
        }

        .box {
            background-color: white;
            padding: 30px;
            border: 1px solid #ddd;
        }

        .box h2 {
            margin-top: 0;
        }

        .field {
            margin-bottom: 20px;
        }

        .field label {
            display: block;
            font-weight: bold;
            margin-bottom: 7px;
        }

        .input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #aaa;
        }

        .textarea {
            width: 100%;
            height: 120px;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #aaa;
            resize: vertical;
        }

        .button {
            padding: 12px 25px;
            background-color: #333;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .message {
            display: block;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="header">

        <a href="UserDashboard.aspx">Dashboard</a>

        <a href="../Logout.aspx">Logout</a>

        <h1>Campus Maintenance Tracker</h1>

        <div>Submit Maintenance Request</div>

    </div>


    <div class="container">

        <div class="box">

            <h2>Report a Maintenance Issue</h2>

            <p>
                Enter the details of the maintenance problem below.
            </p>

            <asp:Label ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>


            <div class="field">

                <label>Category</label>

                <asp:DropDownList
                    ID="ddlCategory"
                    runat="server"
                    CssClass="input">

                    <asp:ListItem
                        Text="-- Select Category --"
                        Value="">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="Electrical"
                        Value="Electrical">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="Plumbing"
                        Value="Plumbing">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="Civil"
                        Value="Civil">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="Cleaning"
                        Value="Cleaning">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="Furniture"
                        Value="Furniture">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="Internet"
                        Value="Internet">
                    </asp:ListItem>

                    <asp:ListItem
                        Text="Other"
                        Value="Other">
                    </asp:ListItem>

                </asp:DropDownList>

            </div>


            <div class="field">

                <label>Location</label>

                <asp:TextBox
                    ID="txtLocation"
                    runat="server"
                    CssClass="input"
                    MaxLength="200">
                </asp:TextBox>

            </div>


            <div class="field">

                <label>Description</label>

                <asp:TextBox
                    ID="txtDescription"
                    runat="server"
                    CssClass="textarea"
                    TextMode="MultiLine"
                    MaxLength="1000">
                </asp:TextBox>

            </div>


            <asp:Button
                ID="btnSubmit"
                runat="server"
                Text="Submit Maintenance Request"
                CssClass="button"
                OnClick="btnSubmit_Click" />

        </div>

    </div>

</form>

</body>

</html>
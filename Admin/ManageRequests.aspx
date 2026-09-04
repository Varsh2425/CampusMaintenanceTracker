<%@ Page Language="VB" CodeFile="ManageRequests.aspx.vb" Inherits="Admin_ManageRequests" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Manage Maintenance Requests</title>

    <style type="text/css">

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .header {
            background-color: #1f2937;
            color: white;
            padding: 25px;
        }

        .header h1 {
            margin: 0;
            font-size: 36px;
        }

        .header p {
            margin: 8px 0 0 0;
            font-size: 20px;
        }

        .nav {
            float: right;
            margin-top: -45px;
        }

        .nav a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
            font-size: 18px;
        }

        .container {
            width: 94%;
            margin: 35px auto;
        }

        .box {
            background-color: white;
            border: 1px solid #ddd;
            padding: 25px;
        }

        .box h2 {
            font-size: 28px;
        }

        .message {
            color: green;
            font-weight: bold;
            font-size: 18px;
        }

        .error {
            color: red;
            font-weight: bold;
            font-size: 18px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            font-size: 14px;
        }

        .grid th {
            background-color: #1f2937;
            color: white;
            padding: 12px;
            border: 1px solid #ddd;
        }

        .grid td {
            padding: 10px;
            border: 1px solid #ddd;
            vertical-align: middle;
        }

        .dropdown {
            padding: 7px;
            font-size: 14px;
            width: 140px;
        }

        .updateButton {
            background-color: #333;
            color: white;
            border: none;
            padding: 8px 14px;
            cursor: pointer;
            font-size: 14px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="header">

        <h1>Campus Maintenance Tracker</h1>

        <p>Manage Maintenance Requests</p>

        <div class="nav">

            <a href="../Logout.aspx">Logout</a>

            <a href="AdminDashboard.aspx">Dashboard</a>

        </div>

    </div>


    <div class="container">

        <div class="box">

            <h2>Maintenance Requests</h2>

            <p>
                View and manage maintenance requests submitted by campus users.
            </p>


            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>


            <asp:GridView
                ID="gvRequests"
                runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="RequestID"
                CssClass="grid"
                GridLines="Both"
                OnRowDataBound="gvRequests_RowDataBound"
                OnRowCommand="gvRequests_RowCommand">

                <Columns>


                    <asp:BoundField
                        DataField="RequestID"
                        HeaderText="Request ID" />


                    <asp:BoundField
                        DataField="UserID"
                        HeaderText="User ID" />


                    <asp:BoundField
                        DataField="Category"
                        HeaderText="Category" />


                    <asp:BoundField
                        DataField="Location"
                        HeaderText="Location" />


                    <asp:BoundField
                        DataField="Description"
                        HeaderText="Description" />


                    <asp:BoundField
                        DataField="DateReported"
                        HeaderText="Date Reported" />


                    <asp:TemplateField HeaderText="Status">

                        <ItemTemplate>

                            <asp:DropDownList
                                ID="ddlStatus"
                                runat="server"
                                CssClass="dropdown">

                                <asp:ListItem
                                    Text="Pending"
                                    Value="Pending" />

                                <asp:ListItem
                                    Text="Assigned"
                                    Value="Assigned" />

                                <asp:ListItem
                                    Text="In Progress"
                                    Value="In Progress" />

                                <asp:ListItem
                                    Text="Completed"
                                    Value="Completed" />

                            </asp:DropDownList>

                        </ItemTemplate>

                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Assigned Staff">

                        <ItemTemplate>

                            <asp:DropDownList
                                ID="ddlStaff"
                                runat="server"
                                CssClass="dropdown">
                            </asp:DropDownList>

                        </ItemTemplate>

                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Action">

                        <ItemTemplate>

                            <asp:Button
                                ID="btnUpdate"
                                runat="server"
                                Text="Update"
                                CssClass="updateButton"
                                CommandName="UpdateRequest"
                                CommandArgument='<%# Eval("RequestID") %>' />

                        </ItemTemplate>

                    </asp:TemplateField>


                </Columns>

            </asp:GridView>

        </div>

    </div>

</form>

</body>

</html> 
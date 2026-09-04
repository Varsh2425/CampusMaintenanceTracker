<%@ Page Language="VB" CodeFile="StaffDashboard.aspx.vb" Inherits="Staff_StaffDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Staff Dashboard - Campus Maintenance Tracker</title>

    <style type="text/css">

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f4f6f8;
        }

        .header {
            background-color: #263238;
            color: white;
            padding: 18px 30px;
            font-size: 24px;
            font-weight: bold;
        }

        .container {
            width: 92%;
            margin: 30px auto;
        }

        .logout {
            float: right;
            color: white;
            text-decoration: none;
            font-size: 14px;
            padding-top: 5px;
        }

        .welcome {
            background-color: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #ddd;
        }

        .welcome h2 {
            margin-top: 0;
            color: #263238;
        }

        .welcome p {
            color: #555;
            font-size: 15px;
        }

        .stats {
            display: flex;
            width: 100%;
            gap: 20px;
            margin-bottom: 20px;
        }

        .stat-card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 20px;
            text-align: center;
            flex: 1;
        }

        .stat-title {
            font-size: 14px;
            font-weight: bold;
            color: #555;
            margin-bottom: 10px;
        }

        .stat-number {
            display: block;
            font-size: 32px;
            font-weight: bold;
            color: #263238;
        }

        .card {
            background-color: white;
            padding: 20px;
            border-radius: 6px;
            border: 1px solid #ddd;
        }

        .card-title {
            font-size: 20px;
            font-weight: bold;
            color: #263238;
            margin-bottom: 15px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
        }

        .grid th {
            background-color: #37474f;
            color: white;
            padding: 12px;
            text-align: left;
        }

        .grid td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            vertical-align: top;
        }

        .grid tr:hover {
            background-color: #f5f5f5;
        }

        .status {
            padding: 7px;
            border: 1px solid #aaa;
            border-radius: 4px;
            width: 130px;
        }

        .update-button {
            background-color: #263238;
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 4px;
            cursor: pointer;
        }

        .update-button:hover {
            background-color: #455a64;
        }

        .message {
            display: block;
            margin-bottom: 15px;
            color: green;
            font-weight: bold;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="header">

        Campus Maintenance Tracker

        <asp:LinkButton ID="btnLogout"
            runat="server"
            CssClass="logout"
            OnClick="btnLogout_Click">
            Logout
        </asp:LinkButton>

    </div>


    <div class="container">


        <div class="welcome">

            <h2>

                Welcome,
                <asp:Label ID="lblStaffName"
                    runat="server">
                </asp:Label>

            </h2>

            <p>
                Manage the maintenance requests assigned to you.
            </p>

            <p>

                Department:

                <strong>

                    <asp:Label ID="lblDepartment"
                        runat="server">
                    </asp:Label>

                </strong>

            </p>

        </div>


        <div class="stats">


            <div class="stat-card">

                <div class="stat-title">
                    TOTAL ASSIGNED
                </div>

                <asp:Label ID="lblTotalAssigned"
                    runat="server"
                    Text="0"
                    CssClass="stat-number">
                </asp:Label>

            </div>


            <div class="stat-card">

                <div class="stat-title">
                    IN PROGRESS
                </div>

                <asp:Label ID="lblInProgress"
                    runat="server"
                    Text="0"
                    CssClass="stat-number">
                </asp:Label>

            </div>


            <div class="stat-card">

                <div class="stat-title">
                    COMPLETED
                </div>

                <asp:Label ID="lblCompleted"
                    runat="server"
                    Text="0"
                    CssClass="stat-number">
                </asp:Label>

            </div>


        </div>


        <div class="card">

            <div class="card-title">
                My Assigned Maintenance Requests
            </div>


            <asp:Label ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>


            <asp:GridView ID="gvRequests"
                runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="RequestID"
                CssClass="grid"
                EmptyDataText="No maintenance requests are currently assigned to you."
                OnRowCommand="gvRequests_RowCommand"
                OnRowDataBound="gvRequests_RowDataBound">


                <Columns>


                    <asp:BoundField
                        DataField="RequestID"
                        HeaderText="Request ID" />


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
                        HeaderText="Date Reported"
                        DataFormatString="{0:dd-MM-yyyy}" />


                    <asp:BoundField
                        DataField="Status"
                        HeaderText="Current Status" />


                    <asp:TemplateField HeaderText="Update Status">

                        <ItemTemplate>

                            <asp:DropDownList
                                ID="ddlStatus"
                                runat="server"
                                CssClass="status">

                                <asp:ListItem
                                    Text="Assigned"
                                    Value="Assigned">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="In Progress"
                                    Value="In Progress">
                                </asp:ListItem>

                                <asp:ListItem
                                    Text="Completed"
                                    Value="Completed">
                                </asp:ListItem>

                            </asp:DropDownList>

                        </ItemTemplate>

                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Action">

                        <ItemTemplate>

                            <asp:Button
                                ID="btnUpdate"
                                runat="server"
                                Text="Update"
                                CommandName="UpdateStatus"
                                CommandArgument='<%# Container.DataItemIndex %>'
                                CssClass="update-button" />

                        </ItemTemplate>

                    </asp:TemplateField>


                </Columns>

            </asp:GridView>


        </div>


    </div>

</form>

</body>

</html>
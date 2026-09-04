<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MaintenanceHistory.aspx.vb" Inherits="Admin_MaintenanceHistory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Maintenance History - Campus Maintenance Tracker</title>

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
            padding: 25px 32px;
            position: relative;
        }

        .header-title
        {
            font-size: 34px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .header-subtitle
        {
            font-size: 20px;
        }

        .nav
        {
            position: absolute;
            right: 32px;
            top: 65px;
        }

        .nav a
        {
            color: #ffffff;
            text-decoration: none;
            font-size: 16px;
            margin-left: 22px;
        }

        .nav a:hover
        {
            text-decoration: underline;
        }

        .container
        {
            width: 92%;
            margin: 35px auto;
        }

        .content-card
        {
            background-color: #ffffff;
            border: 1px solid #d8dde3;
            padding: 30px;
        }

        .page-title
        {
            font-size: 29px;
            font-weight: bold;
            color: #111827;
            margin-bottom: 8px;
        }

        .page-description
        {
            color: #555555;
            font-size: 16px;
            margin-bottom: 25px;
        }

        .history-table
        {
            width: 100%;
            border-collapse: collapse;
            font-size: 15px;
        }

        .history-table th
        {
            background-color: #263238;
            color: #ffffff;
            padding: 13px 10px;
            text-align: left;
            border: 1px solid #263238;
        }

        .history-table td
        {
            padding: 12px 10px;
            border: 1px solid #d8dde3;
            vertical-align: top;
            color: #333333;
        }

        .history-table tr:nth-child(even)
        {
            background-color: #f8fafc;
        }

        .empty-message
        {
            display: block;
            padding: 18px;
            background-color: #fff8e1;
            border: 1px solid #f0d98c;
            color: #6b5314;
            font-size: 15px;
        }

        .error-message
        {
            display: block;
            margin-bottom: 18px;
            padding: 12px;
            background-color: #fdeaea;
            border: 1px solid #e6aaaa;
            color: #a00000;
            font-weight: bold;
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
            Admin Panel
        </div>

        <div class="nav">
            <a href="AdminDashboard.aspx">Dashboard</a>
            <a href="ManageRequests.aspx">Manage Requests</a>
            <a href="ManageStaff.aspx">Manage Staff</a>
            <a href="../Logout.aspx">Logout</a>
        </div>

    </div>

    <div class="container">

        <div class="content-card">

            <div class="page-title">
                Maintenance History
            </div>

            <div class="page-description">
                View a complete record of maintenance request assignments and status updates.
            </div>

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="error-message"
                Visible="false">
            </asp:Label>

            <asp:GridView
                ID="gvHistory"
                runat="server"
                AutoGenerateColumns="false"
                CssClass="history-table"
                GridLines="None"
                EmptyDataText="No maintenance history records are available.">

                <EmptyDataTemplate>
                    <span class="empty-message">
                        No maintenance history records are available.
                    </span>
                </EmptyDataTemplate>

                <Columns>

                    <asp:BoundField
                        DataField="RequestID"
                        HeaderText="Request ID" />

                    <asp:BoundField
                        DataField="StaffName"
                        HeaderText="Updated By" />

                    <asp:BoundField
                        DataField="Action"
                        HeaderText="Action" />

                    <asp:BoundField
                        DataField="UpdatedDate"
                        HeaderText="Updated Date"
                        DataFormatString="{0:dd-MM-yyyy hh:mm tt}" />

                    <asp:BoundField
                        DataField="Remarks"
                        HeaderText="Remarks" />

                </Columns>

            </asp:GridView>

        </div>

    </div>

</form>

</body>

</html>
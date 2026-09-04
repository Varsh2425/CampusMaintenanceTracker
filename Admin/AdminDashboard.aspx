<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AdminDashboard.aspx.vb" Inherits="Admin_AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Admin Dashboard - Campus Maintenance Tracker</title>

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

        .header p {
            margin: 5px 0 0 0;
        }

        .container {
            width: 90%;
            margin: 30px auto;
        }

        .welcome {
            background-color: white;
            padding: 20px;
            margin-bottom: 25px;
            border: 1px solid #ddd;
        }

        .cards {
            display: table;
            width: 100%;
            border-spacing: 15px;
            margin-left: -15px;
        }

        .card {
            display: table-cell;
            width: 33%;
            background-color: white;
            padding: 25px;
            border: 1px solid #ddd;
            text-align: center;
        }

        .card h2 {
            margin-top: 0;
        }

        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #333;
            color: white;
            text-decoration: none;
            margin-top: 10px;
        }

        .logout {
            float: right;
            color: white;
            text-decoration: none;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="header">

        <a href="../Logout.aspx" class="logout">Logout</a>

        <h1>Campus Maintenance Tracker</h1>

        <p>Administrator Dashboard</p>

    </div>

    <div class="container">

        <div class="welcome">

            <h2>
                Welcome, <asp:Label ID="lblAdminName"
                    runat="server">
                </asp:Label>
            </h2>

            <p>
                Manage campus maintenance requests, staff assignments,
                and maintenance activities from this dashboard.
            </p>

        </div>

        <div class="cards">

            <div class="card">

                <h2>Maintenance Requests</h2>

                <p>
                    View and manage maintenance requests submitted by users.
                </p>

                <a href="ManageRequests.aspx" class="button">
                    Manage Requests
                </a>

            </div>

            <div class="card">

                <h2>Staff Management</h2>

                <p>
                    View staff members and manage staff assignments.
                </p>

                <a href="ManageStaff.aspx" class="button">
                    Manage Staff
                </a>

            </div>

            <div class="card">

                <h2>Maintenance History</h2>

                <p>
                    View completed and previous maintenance activities.
                </p>

                <a href="MaintenanceHistory.aspx" class="button">
                    View History
                </a>

            </div>

        </div>

    </div>

</form>

</body>

</html>
<%@ Page Language="VB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title>User Dashboard - Campus Maintenance Tracker</title>

    <style type="text/css">

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .header {
            background-color: #1f2937;
            color: white;
            padding: 25px 35px;
        }

        .header h1 {
            margin: 0;
            font-size: 36px;
        }

        .header p {
            margin-top: 10px;
            font-size: 20px;
        }

        .nav {
            float: right;
            margin-top: -55px;
        }

        .nav a {
            color: white;
            text-decoration: none;
            margin-left: 25px;
            font-size: 18px;
        }

        .container {
            width: 90%;
            margin: 40px auto;
        }

        .welcome {
            background-color: white;
            border: 1px solid #ddd;
            padding: 35px;
            margin-bottom: 40px;
        }

        .welcome h2 {
            font-size: 30px;
        }

        .cards {
            display: flex;
            gap: 25px;
        }

        .card {
            background-color: white;
            border: 1px solid #ddd;
            width: 33%;
            min-height: 220px;
            text-align: center;
            padding: 30px;
            box-sizing: border-box;
        }

        .card h2 {
            font-size: 26px;
        }

        .card p {
            font-size: 18px;
            line-height: 1.5;
        }

        .button {
            display: inline-block;
            background-color: #333;
            color: white;
            text-decoration: none;
            padding: 15px 25px;
            margin-top: 15px;
            font-size: 17px;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="header">

        <h1>Campus Maintenance Tracker</h1>

        <p>User Dashboard</p>

        <div class="nav">
            <a href="../Logout.aspx">Logout</a>
        </div>

    </div>


    <div class="container">

        <div class="welcome">

            <h2>Welcome, Student!</h2>

            <p>
                Submit maintenance requests and track the status
                of your requests from this dashboard.
            </p>

        </div>


        <div class="cards">

            <div class="card">

                <h2>Submit Request</h2>

                <p>
                    Report a maintenance issue on campus.
                </p>

                <a class="button" href="SubmitRequest.aspx">
                    Submit Request
                </a>

            </div>


            <div class="card">

                <h2>My Requests</h2>

                <p>
                    View the maintenance requests you have submitted
                    and check their current status.
                </p>

                <a class="button" href="MyRequests.aspx">
                    View Requests
                </a>

            </div>


            <div class="card">

                <h2>Profile</h2>

                <p>
                    View your account information.
                </p>

                <a class="button" href="Profile.aspx">
                    View Profile
                </a>

            </div>

        </div>

    </div>

</form>

</body>

</html>
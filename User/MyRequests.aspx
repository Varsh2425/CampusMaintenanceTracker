<%@ Page Language="VB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>My Maintenance Requests</title>

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

        .grid tr:nth-child(even) {
            background-color: #f5f5f5;
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="header">

        <h1>Campus Maintenance Tracker</h1>

        <p>My Maintenance Requests</p>

        <div class="nav">

            <a href="../Logout.aspx">Logout</a>

            <a href="UserDashboard.aspx">Dashboard</a>

        </div>

    </div>


    <div class="container">

        <div class="box">

            <h2>My Requests</h2>

            <p>
                View the maintenance requests you have submitted and
                check their current status.
            </p>


            <asp:Label ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>


            <asp:GridView ID="gvMyRequests"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="grid"
                GridLines="Both">

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
                        HeaderText="Date Reported" />

                    <asp:BoundField
                        DataField="Status"
                        HeaderText="Status" />

                    <asp:BoundField
                        DataField="StaffName"
                        HeaderText="Assigned Staff" />

                </Columns>

            </asp:GridView>

        </div>

    </div>

</form>


<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs)

        If Not IsPostBack Then

            LoadMyRequests()

        End If

    End Sub


    Private Sub LoadMyRequests()

        Try

            '================================================
            ' GET LOGGED-IN USER ID
            '================================================

            If Session("UserID") Is Nothing Then

                Response.Redirect("../Login.aspx")

                Return

            End If


            Dim userID As Integer = _
                Convert.ToInt32(Session("UserID"))


            '================================================
            ' DATABASE CONNECTION
            '================================================

            Dim con As _
                MySql.Data.MySqlClient.MySqlConnection = _
                DBConnection.GetConnection()


            '================================================
            ' GET ONLY THIS USER'S REQUESTS
            '================================================

            Dim sql As String = _
                "SELECT r.RequestID, " & _
                "r.Category, " & _
                "r.Location, " & _
                "r.Description, " & _
                "r.DateReported, " & _
                "r.Status, " & _
                "IFNULL(s.Name, 'Not Assigned') AS StaffName " & _
                "FROM maintenancerequests r " & _
                "LEFT JOIN staff s " & _
                "ON r.AssignedStaffID = s.StaffID " & _
                "WHERE r.UserID = @UserID " & _
                "ORDER BY r.RequestID DESC"


            Dim cmd As New _
                MySql.Data.MySqlClient.MySqlCommand( _
                sql, con)


            cmd.Parameters.AddWithValue( _
                "@UserID", userID)


            '================================================
            ' LOAD DATA
            '================================================

            Dim adapter As New _
                MySql.Data.MySqlClient.MySqlDataAdapter(cmd)


            Dim table As New System.Data.DataTable()


            adapter.Fill(table)


            gvMyRequests.DataSource = table

            gvMyRequests.DataBind()


            con.Close()


            '================================================
            ' MESSAGE
            '================================================

            If table.Rows.Count = 0 Then

                lblMessage.CssClass = "message"

                lblMessage.Text = _
                    "You have not submitted any maintenance requests yet."

            Else

                lblMessage.CssClass = "message"

                lblMessage.Text = _
                    table.Rows.Count.ToString() & _
                    " maintenance request(s) found."

            End If


        Catch ex As Exception

            lblMessage.CssClass = "error"

            lblMessage.Text = _
                "ERROR: " & ex.Message

        End Try

    End Sub

</script>


</body>

</html>
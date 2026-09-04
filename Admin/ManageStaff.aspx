<%@ Page Language="VB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">

    <title>Manage Staff</title>

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
            font-size: 16px;
        }

        .grid th {
            background-color: #1f2937;
            color: white;
            padding: 14px;
            border: 1px solid #ddd;
        }

        .grid td {
            padding: 12px;
            border: 1px solid #ddd;
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

        <p>Staff Management</p>

        <div class="nav">

            <a href="../Logout.aspx">Logout</a>

            <a href="AdminDashboard.aspx">Dashboard</a>

        </div>

    </div>


    <div class="container">

        <div class="box">

            <h2>Staff Management</h2>

            <p>
                View the staff members available for maintenance assignments.
            </p>


            <asp:Label ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>


            <asp:GridView ID="gvStaff"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="grid"
                GridLines="Both">

                <Columns>

                    <asp:BoundField
                        DataField="StaffID"
                        HeaderText="Staff ID" />

                    <asp:BoundField
                        DataField="Name"
                        HeaderText="Staff Name" />

                    <asp:BoundField
                        DataField="Department"
                        HeaderText="Department" />

                    <asp:BoundField
                        DataField="Contact"
                        HeaderText="Contact" />

                </Columns>

            </asp:GridView>

        </div>

    </div>

</form>


<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs)

        If Not IsPostBack Then

            LoadStaff()

        End If

    End Sub


    Private Sub LoadStaff()

        Try

            Dim con As MySql.Data.MySqlClient.MySqlConnection = _
                DBConnection.GetConnection()


            Dim sql As String = _
                "SELECT StaffID, Name, Department, Contact " & _
                "FROM staff " & _
                "ORDER BY StaffID"


            Dim cmd As New MySql.Data.MySqlClient.MySqlCommand( _
                sql, con)


            Dim adapter As New _
                MySql.Data.MySqlClient.MySqlDataAdapter(cmd)


            Dim table As New System.Data.DataTable()


            adapter.Fill(table)


            gvStaff.DataSource = table

            gvStaff.DataBind()


            con.Close()


            If table.Rows.Count = 0 Then

                lblMessage.CssClass = "message"

                lblMessage.Text = _
                    "No staff members found."

            Else

                lblMessage.CssClass = "message"

                lblMessage.Text = _
                    table.Rows.Count.ToString() & _
                    " staff member(s) found."

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
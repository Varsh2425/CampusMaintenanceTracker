Imports System
Imports System.Data
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports MySql.Data.MySqlClient

Partial Class Staff_StaffDashboard

    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, _
                            ByVal e As System.EventArgs) Handles Me.Load

        If Session("UserID") Is Nothing Then

            Response.Redirect("~/Login.aspx")
            Return

        End If


        If Session("Role") Is Nothing OrElse _
           Session("Role").ToString().ToLower() <> "staff" Then

            Response.Redirect("~/Login.aspx")
            Return

        End If


        If Not IsPostBack Then

            LoadStaffDetails()
            LoadRequests()
            LoadStatistics()

        End If

    End Sub


    Private Sub LoadStaffDetails()

        Try

            Dim userID As Integer = _
                Convert.ToInt32(Session("UserID"))


            Using con As MySqlConnection = DBConnection.GetConnection()

                con.Open()


                Dim query As String = _
                    "SELECT s.StaffID, s.Name, s.Department " & _
                    "FROM staff s " & _
                    "WHERE s.UserID = @UserID"


                Using cmd As New MySqlCommand(query, con)

                    cmd.Parameters.AddWithValue("@UserID", userID)


                    Using reader As MySqlDataReader = cmd.ExecuteReader()

                        If reader.Read() Then

                            Session("StaffID") = _
                                Convert.ToInt32(reader("StaffID"))

                            lblStaffName.Text = _
                                reader("Name").ToString()

                            lblDepartment.Text = _
                                reader("Department").ToString()

                        Else

                            lblMessage.Text = _
                                "Staff profile not found."

                            lblMessage.ForeColor = _
                                Drawing.Color.Red

                        End If

                    End Using

                End Using

            End Using


        Catch ex As Exception

            lblMessage.Text = _
                "Error loading staff details: " & ex.Message

            lblMessage.ForeColor = Drawing.Color.Red

        End Try

    End Sub


    Private Sub LoadRequests()

        Try

            If Session("StaffID") Is Nothing Then
                Return
            End If


            Dim staffID As Integer = _
                Convert.ToInt32(Session("StaffID"))


            Using con As MySqlConnection = DBConnection.GetConnection()

                con.Open()


                Dim query As String = _
                    "SELECT RequestID, UserID, Category, Location, " & _
                    "Description, DateReported, Status " & _
                    "FROM maintenancerequests " & _
                    "WHERE AssignedStaffID = @StaffID " & _
                    "ORDER BY RequestID DESC"


                Using cmd As New MySqlCommand(query, con)

                    cmd.Parameters.AddWithValue("@StaffID", staffID)


                    Dim adapter As New MySqlDataAdapter(cmd)
                    Dim dt As New DataTable()

                    adapter.Fill(dt)

                    gvRequests.DataSource = dt
                    gvRequests.DataBind()

                End Using

            End Using


        Catch ex As Exception

            lblMessage.Text = _
                "Error loading requests: " & ex.Message

            lblMessage.ForeColor = Drawing.Color.Red

        End Try

    End Sub


    Private Sub LoadStatistics()

        Try

            If Session("StaffID") Is Nothing Then
                Return
            End If


            Dim staffID As Integer = _
                Convert.ToInt32(Session("StaffID"))


            Using con As MySqlConnection = DBConnection.GetConnection()

                con.Open()


                Dim query As String = _
                    "SELECT " & _
                    "COUNT(*) AS TotalAssigned, " & _
                    "SUM(CASE WHEN Status = 'In Progress' THEN 1 ELSE 0 END) AS InProgress, " & _
                    "SUM(CASE WHEN Status = 'Completed' THEN 1 ELSE 0 END) AS Completed " & _
                    "FROM maintenancerequests " & _
                    "WHERE AssignedStaffID = @StaffID"


                Using cmd As New MySqlCommand(query, con)

                    cmd.Parameters.AddWithValue("@StaffID", staffID)


                    Using reader As MySqlDataReader = cmd.ExecuteReader()

                        If reader.Read() Then

                            lblTotalAssigned.Text = _
                                reader("TotalAssigned").ToString()


                            If Convert.IsDBNull(reader("InProgress")) Then

                                lblInProgress.Text = "0"

                            Else

                                lblInProgress.Text = _
                                    reader("InProgress").ToString()

                            End If


                            If Convert.IsDBNull(reader("Completed")) Then

                                lblCompleted.Text = "0"

                            Else

                                lblCompleted.Text = _
                                    reader("Completed").ToString()

                            End If

                        End If

                    End Using

                End Using

            End Using


        Catch ex As Exception

            lblMessage.Text = _
                "Error loading statistics: " & ex.Message

            lblMessage.ForeColor = Drawing.Color.Red

        End Try

    End Sub


    Protected Sub gvRequests_RowDataBound( _
        ByVal sender As Object, _
        ByVal e As GridViewRowEventArgs)

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim ddlStatus As DropDownList = _
                CType(e.Row.FindControl("ddlStatus"), DropDownList)


            If ddlStatus IsNot Nothing Then

                Dim currentStatus As String = _
                    DataBinder.Eval(e.Row.DataItem, "Status").ToString()


                If ddlStatus.Items.FindByValue(currentStatus) IsNot Nothing Then

                    ddlStatus.SelectedValue = currentStatus

                End If

            End If

        End If

    End Sub


    Protected Sub gvRequests_RowCommand( _
        ByVal sender As Object, _
        ByVal e As GridViewCommandEventArgs)

        If e.CommandName = "UpdateStatus" Then

            Try

                If Session("StaffID") Is Nothing Then

                    Response.Redirect("~/Login.aspx")
                    Return

                End If


                Dim staffID As Integer = _
                    Convert.ToInt32(Session("StaffID"))

                Dim rowIndex As Integer = _
                    Convert.ToInt32(e.CommandArgument)

                Dim row As GridViewRow = _
                    gvRequests.Rows(rowIndex)

                Dim ddlStatus As DropDownList = _
                    CType(row.FindControl("ddlStatus"), DropDownList)

                Dim requestID As Integer = _
                    Convert.ToInt32(gvRequests.DataKeys(rowIndex).Value)

                Dim newStatus As String = _
                    ddlStatus.SelectedValue


                Using con As MySqlConnection = DBConnection.GetConnection()

                    con.Open()

                    Dim dbTransaction As MySqlTransaction = _
                        con.BeginTransaction()

                    Try

                        Dim updateQuery As String = _
                            "UPDATE maintenancerequests " & _
                            "SET Status = @Status " & _
                            "WHERE RequestID = @RequestID " & _
                            "AND AssignedStaffID = @StaffID " & _
                            "AND Status <> @Status"


                        Using updateCmd As New MySqlCommand( _
                            updateQuery, con, dbTransaction)

                            updateCmd.Parameters.AddWithValue( _
                                "@Status", newStatus)

                            updateCmd.Parameters.AddWithValue( _
                                "@RequestID", requestID)

                            updateCmd.Parameters.AddWithValue( _
                                "@StaffID", staffID)


                            Dim rowsAffected As Integer = _
                                updateCmd.ExecuteNonQuery()


                            If rowsAffected > 0 Then

                                If newStatus.ToLower() = "completed" Then

                                    Dim historyQuery As String = _
                                        "INSERT INTO maintenancehistory " & _
                                        "(RequestID, StaffID, Action, UpdatedDate, Remarks) " & _
                                        "VALUES " & _
                                        "(@RequestID, @StaffID, @Action, NOW(), @Remarks)"


                                    Using historyCmd As New MySqlCommand( _
                                        historyQuery, con, dbTransaction)

                                        historyCmd.Parameters.AddWithValue( _
                                            "@RequestID", requestID)

                                        historyCmd.Parameters.AddWithValue( _
                                            "@StaffID", staffID)

                                        historyCmd.Parameters.AddWithValue( _
                                            "@Action", "Completed")

                                        historyCmd.Parameters.AddWithValue( _
                                            "@Remarks", _
                                            "Maintenance task completed by staff.")

                                        historyCmd.ExecuteNonQuery()

                                    End Using

                                End If


                                dbTransaction.Commit()

                                lblMessage.Text = _
                                    "Request #" & requestID.ToString() & _
                                    " status updated successfully."

                                lblMessage.ForeColor = _
                                    Drawing.Color.Green

                            Else

                                dbTransaction.Rollback()

                                lblMessage.Text = _
                                    "No change was made. The request may already have this status."

                                lblMessage.ForeColor = _
                                    Drawing.Color.Red

                            End If

                        End Using


                    Catch ex As Exception

                        dbTransaction.Rollback()
                        Throw

                    End Try

                End Using


                LoadRequests()
                LoadStatistics()


            Catch ex As Exception

                lblMessage.Text = _
                    "Error updating request: " & ex.Message

                lblMessage.ForeColor = Drawing.Color.Red

            End Try

        End If

    End Sub


    Protected Sub btnLogout_Click( _
        ByVal sender As Object, _
        ByVal e As System.EventArgs)

        Session.Clear()
        Session.Abandon()

        Response.Redirect("~/Login.aspx")

    End Sub


End Class
Imports System
Imports System.Data
Imports MySql.Data.MySqlClient

Partial Class Admin_MaintenanceHistory

    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        If Session("UserID") Is Nothing OrElse
           Session("Role") Is Nothing OrElse
           Session("Role").ToString().ToLower() <> "admin" Then

            Response.Redirect("~/Login.aspx")
            Return

        End If


        If Not IsPostBack Then

            LoadMaintenanceHistory()

        End If

    End Sub


    Private Sub LoadMaintenanceHistory()

        Try

            Dim query As String = _
                "SELECT h.RequestID, " & _
                "CASE " & _
                "WHEN h.StaffID IS NULL THEN 'Admin / Not Assigned' " & _
                "WHEN s.Name IS NULL OR s.Name = '' THEN 'Staff Not Found' " & _
                "ELSE s.Name " & _
                "END AS StaffName, " & _
                "h.Action, h.UpdatedDate, " & _
                "IFNULL(h.Remarks, '') AS Remarks " & _
                "FROM maintenancehistory h " & _
                "LEFT JOIN staff s ON h.StaffID = s.StaffID " & _
                "ORDER BY h.UpdatedDate DESC, h.HistoryID DESC"

            Using con As MySqlConnection = DBConnection.GetConnection()

                Using cmd As New MySqlCommand(query, con)

                    Using adapter As New MySqlDataAdapter(cmd)

                        Dim historyTable As New DataTable()

                        adapter.Fill(historyTable)

                        gvHistory.DataSource = historyTable
                        gvHistory.DataBind()

                    End Using

                End Using

            End Using

        Catch ex As Exception

            lblMessage.Visible = True
            lblMessage.Text = "Unable to load maintenance history: " & ex.Message

        End Try

    End Sub


End Class
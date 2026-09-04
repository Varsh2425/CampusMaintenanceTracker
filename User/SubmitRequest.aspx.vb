Imports System
Imports System.Data
Imports MySql.Data.MySqlClient

Partial Class User_SubmitRequest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs)

        'Check login
        If Session("UserID") Is Nothing Then

            Response.Redirect("~/Login.aspx")
            Return

        End If

        'Check User role
        If Session("Role") Is Nothing OrElse
           Session("Role").ToString().ToLower() <> "user" Then

            Response.Redirect("~/Login.aspx")
            Return

        End If

    End Sub


    Protected Sub btnSubmit_Click(ByVal sender As Object,
                                  ByVal e As System.EventArgs)

        lblMessage.Text = ""

        'Validate category
        If ddlCategory.SelectedValue = "" Then

            lblMessage.Text = "Please select a category."
            lblMessage.CssClass = "message error"
            Return

        End If


        'Validate location
        If txtLocation.Text.Trim() = "" Then

            lblMessage.Text = "Please enter the location."
            lblMessage.CssClass = "message error"
            Return

        End If


        'Validate description
        If txtDescription.Text.Trim() = "" Then

            lblMessage.Text = "Please describe the maintenance problem."
            lblMessage.CssClass = "message error"
            Return

        End If


        Dim con As MySqlConnection = Nothing

        Try

            con = DBConnection.GetConnection()
            con.Open()


            Dim query As String = _
                "INSERT INTO maintenancerequests " & _
                "(UserID, Category, Location, Description, DateReported, Status, AssignedStaffID) " & _
                "VALUES (@UserID, @Category, @Location, @Description, NOW(), 'Pending', NULL)"


            Dim cmd As New MySqlCommand(query, con)


            cmd.Parameters.AddWithValue(
                "@UserID",
                Convert.ToInt32(Session("UserID"))
            )

            cmd.Parameters.AddWithValue(
                "@Category",
                ddlCategory.SelectedValue
            )

            cmd.Parameters.AddWithValue(
                "@Location",
                txtLocation.Text.Trim()
            )

            cmd.Parameters.AddWithValue(
                "@Description",
                txtDescription.Text.Trim()
            )


            cmd.ExecuteNonQuery()


            lblMessage.Text = _
                "Maintenance request submitted successfully!"

            lblMessage.CssClass = "message success"


            'Clear form

            ddlCategory.SelectedIndex = 0
            txtLocation.Text = ""
            txtDescription.Text = ""


        Catch ex As Exception

            lblMessage.Text = _
                "Error submitting request: " & ex.Message

            lblMessage.CssClass = "message error"


        Finally

            If con IsNot Nothing Then

                If con.State = ConnectionState.Open Then
                    con.Close()
                End If

            End If

        End Try

    End Sub

End Class
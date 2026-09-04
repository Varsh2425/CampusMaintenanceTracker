Imports System
Imports System.Data
Imports MySql.Data.MySqlClient

Partial Class Login
    Inherits System.Web.UI.Page

    Protected Sub btnLogin_Click(ByVal sender As Object, _
                                 ByVal e As System.EventArgs)

        Dim email As String = txtEmail.Text.Trim()
        Dim password As String = txtPassword.Text.Trim()

        If email = "" Or password = "" Then
            lblMessage.Text = "Please enter email and password."
            Return
        End If

        Dim con As MySqlConnection = Nothing

        Try
            con = DBConnection.GetConnection()
            con.Open()

            Dim query As String = _
                "SELECT UserID, Name, Role FROM Users " & _
                "WHERE Email = @Email AND Password = @Password"

            Dim cmd As New MySqlCommand(query, con)

            cmd.Parameters.AddWithValue("@Email", email)
            cmd.Parameters.AddWithValue("@Password", password)

            Dim reader As MySqlDataReader = cmd.ExecuteReader()

            If reader.Read() Then

                Dim userID As Integer = Convert.ToInt32(reader("UserID"))
                Dim name As String = reader("Name").ToString()
                Dim role As String = reader("Role").ToString()

                Session("UserID") = userID
                Session("Name") = name
                Session("Role") = role
                Session("Email") = email

                reader.Close()
                con.Close()

                If role.ToLower() = "admin" Then

                    Response.Redirect("~/Admin/AdminDashboard.aspx")

                ElseIf role.ToLower() = "staff" Then

                    Response.Redirect("~/Staff/StaffDashboard.aspx")

                Else

                    Response.Redirect("~/User/UserDashboard.aspx")

                End If

            Else

                lblMessage.Text = "Invalid email or password."

                reader.Close()

            End If

        Catch ex As Exception

            lblMessage.Text = "Error: " & ex.Message

        Finally

            If con IsNot Nothing Then
                If con.State = ConnectionState.Open Then
                    con.Close()
                End If
            End If

        End Try

    End Sub

End Class
Imports System
Imports System.Data
Imports MySql.Data.MySqlClient

Partial Class Register

    Inherits System.Web.UI.Page


    Protected Sub btnRegister_Click(ByVal sender As Object,
                                    ByVal e As System.EventArgs)

        Dim name As String
        Dim email As String
        Dim password As String
        Dim contact As String

        name = txtName.Text.Trim()
        email = txtEmail.Text.Trim()
        password = txtPassword.Text.Trim()
        contact = txtContact.Text.Trim()


        'Check name

        If name = "" Then

            lblMessage.Text = "Please enter your full name."
            lblMessage.ForeColor = Drawing.Color.Red

            Return

        End If


        'Check email

        If email = "" Then

            lblMessage.Text = "Please enter your email address."
            lblMessage.ForeColor = Drawing.Color.Red

            Return

        End If


        'Check password

        If password = "" Then

            lblMessage.Text = "Please enter a password."
            lblMessage.ForeColor = Drawing.Color.Red

            Return

        End If


        'Check contact

        If contact = "" Then

            lblMessage.Text = "Please enter your contact number."
            lblMessage.ForeColor = Drawing.Color.Red

            Return

        End If


        Dim con As MySqlConnection = Nothing


        Try

            con = DBConnection.GetConnection()

            con.Open()


            'Check whether email already exists

            Dim checkQuery As String

            checkQuery =
                "SELECT COUNT(*) FROM users " &
                "WHERE Email = @Email"


            Using checkCmd As New MySqlCommand(
                checkQuery, con)


                checkCmd.Parameters.AddWithValue(
                    "@Email",
                    email)


                Dim existingUser As Integer

                existingUser =
                    Convert.ToInt32(
                        checkCmd.ExecuteScalar())


                If existingUser > 0 Then

                    lblMessage.Text =
                        "An account with this email already exists."

                    lblMessage.ForeColor =
                        Drawing.Color.Red

                    Return

                End If

            End Using


            'Create new user account

            Dim insertQuery As String

            insertQuery =
                "INSERT INTO users " &
                "(Name, Email, Password, Role, Contact) " &
                "VALUES " &
                "(@Name, @Email, @Password, @Role, @Contact)"


            Using cmd As New MySqlCommand(
                insertQuery, con)


                cmd.Parameters.AddWithValue(
                    "@Name",
                    name)


                cmd.Parameters.AddWithValue(
                    "@Email",
                    email)


                cmd.Parameters.AddWithValue(
                    "@Password",
                    password)


                cmd.Parameters.AddWithValue(
                    "@Role",
                    "User")


                cmd.Parameters.AddWithValue(
                    "@Contact",
                    contact)


                cmd.ExecuteNonQuery()


            End Using


            'Registration successful

            lblMessage.Text =
                "Account created successfully! You can now login."

            lblMessage.ForeColor =
                Drawing.Color.Green


            'Clear the fields

            txtName.Text = ""
            txtEmail.Text = ""
            txtPassword.Text = ""
            txtContact.Text = ""


        Catch ex As Exception

            lblMessage.Text =
                "Error creating account: " &
                ex.Message

            lblMessage.ForeColor =
                Drawing.Color.Red


        Finally

            If con IsNot Nothing Then

                If con.State =
                   ConnectionState.Open Then

                    con.Close()

                End If

            End If

        End Try


    End Sub


End Class
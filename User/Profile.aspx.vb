Imports System
Imports System.Web.UI
Imports MySql.Data.MySqlClient

Partial Class User_Profile

    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs) Handles Me.Load

        'Check whether the user is logged in
        If Session("UserID") Is Nothing Then

            Response.Redirect("~/Login.aspx")
            Return

        End If


        'Load profile only when the page is opened
        If Not IsPostBack Then

            LoadProfile()

        End If

    End Sub


    Private Sub LoadProfile()

        Try

            Dim userID As Integer =
                Convert.ToInt32(Session("UserID"))


            Using con As MySqlConnection =
                DBConnection.GetConnection()

                con.Open()


                Dim query As String =
                    "SELECT Name, Email, Contact, Role " &
                    "FROM users " &
                    "WHERE UserID = @UserID"


                Using cmd As New MySqlCommand(query, con)

                    cmd.Parameters.AddWithValue(
                        "@UserID",
                        userID)


                    Using reader As MySqlDataReader =
                        cmd.ExecuteReader()


                        If reader.Read() Then

                            lblName.Text =
                                reader("Name").ToString()


                            lblEmail.Text =
                                reader("Email").ToString()


                            If IsDBNull(reader("Contact")) Then

                                lblContact.Text = "Not provided"

                            Else

                                lblContact.Text =
                                    reader("Contact").ToString()

                            End If


                            lblRole.Text =
                                reader("Role").ToString()


                        Else

                            lblMessage.Text =
                                "Profile information not found."

                            lblMessage.ForeColor =
                                Drawing.Color.Red

                        End If


                    End Using

                End Using

            End Using


        Catch ex As Exception

            lblMessage.Text =
                "Error loading profile: " &
                ex.Message

            lblMessage.ForeColor =
                Drawing.Color.Red

        End Try

    End Sub


End Class
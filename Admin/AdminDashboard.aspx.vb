Imports System

Partial Class Admin_AdminDashboard
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, _
                            ByVal e As System.EventArgs)

        If Session("UserID") Is Nothing Then

            Response.Redirect("~/Login.aspx")
            Return

        End If

        If Session("Role") Is Nothing OrElse _
           Session("Role").ToString().ToLower() <> "admin" Then

            Response.Redirect("~/Login.aspx")
            Return

        End If

        If Not IsPostBack Then

            If Session("Name") IsNot Nothing Then

                lblAdminName.Text = Session("Name").ToString()

            End If

        End If

    End Sub

End Class
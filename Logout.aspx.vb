Imports System
Imports System.Web.UI

Partial Class Logout

    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, _
                            ByVal e As System.EventArgs) Handles Me.Load

        Session.Clear()

        Session.Abandon()

        Response.Cache.SetCacheability( _
            System.Web.HttpCacheability.NoCache)

        Response.Cache.SetNoStore()

        Response.Redirect("~/Login.aspx")

    End Sub


End Class
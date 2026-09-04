<%@ Page Language="VB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Database Connection Test</title>
</head>

<body>

<form id="form1" runat="server">

    <asp:Label ID="lblMessage"
        runat="server"
        Font-Size="Large">
    </asp:Label>

</form>

</body>
</html>

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim con As MySql.Data.MySqlClient.MySqlConnection = Nothing

        Try

            con = DBConnection.GetConnection()

            con.Open()

            lblMessage.Text = "SUCCESS! MySQL Database Connected."

        Catch ex As Exception

            Dim errorMessage As String = ""

            errorMessage = "ERROR: " & ex.Message

            If ex.InnerException IsNot Nothing Then
                errorMessage &= "<br/><br/>INNER ERROR: " & _
                                ex.InnerException.Message
            End If

            lblMessage.Text = errorMessage

        Finally

            If con IsNot Nothing Then
                If con.State = Data.ConnectionState.Open Then
                    con.Close()
                End If
            End If

        End Try

    End Sub

</script>
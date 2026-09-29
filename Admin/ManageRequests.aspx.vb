Imports System
Imports System.Data
Imports System.IO
Imports System.Net
Imports System.Text
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Xml
Imports MySql.Data.MySqlClient

Partial Class Admin_ManageRequests

    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object,
                            ByVal e As System.EventArgs)

        If Session("UserID") Is Nothing Then

            Response.Redirect("~/Login.aspx")
            Return

        End If


        If Session("Role") Is Nothing OrElse
           Session("Role").ToString().ToLower() <> "admin" Then

            Response.Redirect("~/Login.aspx")
            Return

        End If


        If Not IsPostBack Then

            LoadRequests()

        End If

    End Sub


    '=========================================================
    ' LOAD REQUESTS THROUGH WEB SERVICE
    '=========================================================
    Private Sub LoadRequests()

        Try

            Dim dt As DataTable = GetRequestsFromWebService()

            gvRequests.DataSource = dt
            gvRequests.DataBind()


            If dt.Rows.Count = 0 Then

                lblMessage.Text = _
                    "No maintenance requests found."

            Else

                lblMessage.Text = _
                    dt.Rows.Count.ToString() & _
                    " maintenance request(s) received."

            End If


        Catch ex As Exception

            lblMessage.CssClass = "error"

            lblMessage.Text = _
                "Error loading requests through Web Service: " &
                ex.Message

        End Try

    End Sub


    '=========================================================
    ' CALL ASMX WEB SERVICE
    '=========================================================
    Private Function GetRequestsFromWebService() As DataTable

        Dim dt As New DataTable()

        dt.Columns.Add("RequestID", GetType(Integer))
        dt.Columns.Add("UserID", GetType(Integer))
        dt.Columns.Add("Category", GetType(String))
        dt.Columns.Add("Location", GetType(String))
        dt.Columns.Add("Description", GetType(String))
        dt.Columns.Add("DateReported", GetType(DateTime))
        dt.Columns.Add("Status", GetType(String))
        dt.Columns.Add("AssignedStaffID", GetType(Integer))


        Dim url As String = _
            "http://localhost:26157/CampusMaintenanceTracker/MaintenanceService.asmx"


        Dim soapEnvelope As String =
            "<?xml version=""1.0"" encoding=""utf-8""?>" &
            "<soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" " &
            "xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" " &
            "xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">" &
            "<soap:Body>" &
            "<GetAllRequests xmlns=""http://campusmaintenancetracker/"" />" &
            "</soap:Body>" &
            "</soap:Envelope>"


        Dim request As HttpWebRequest =
            CType(
                WebRequest.Create(url), 
                HttpWebRequest)


        request.Method = "POST"

        request.ContentType = "text/xml; charset=utf-8"

        request.Headers.Add(
            "SOAPAction",
            """http://campusmaintenancetracker/GetAllRequests""")


        Dim bytes() As Byte =
            Encoding.UTF8.GetBytes(soapEnvelope)


        request.ContentLength = bytes.Length


        Using stream As Stream =
            request.GetRequestStream()

            stream.Write(
                bytes,
                0,
                bytes.Length)

        End Using


        Dim response As HttpWebResponse =
            CType(
                request.GetResponse(), 
                HttpWebResponse)


        Dim responseText As String = ""


        Using reader As New StreamReader(
            response.GetResponseStream())

            responseText = reader.ReadToEnd()

        End Using


        Dim xmlDoc As New XmlDocument()

        xmlDoc.LoadXml(responseText)


        Dim namespaceManager As New XmlNamespaceManager(
            xmlDoc.NameTable)


        namespaceManager.AddNamespace(
            "soap",
            "http://schemas.xmlsoap.org/soap/envelope/")


        namespaceManager.AddNamespace(
            "m",
            "http://campusmaintenancetracker/")


        Dim resultNode As XmlNode =
            xmlDoc.SelectSingleNode(
                "//m:GetAllRequestsResponse/m:GetAllRequestsResult",
                namespaceManager)


        If resultNode Is Nothing Then

            Throw New Exception(
                "Web Service did not return maintenance request data.")

        End If


        Dim requestNodes As XmlNodeList =
            resultNode.SelectNodes(
                ".//*[local-name()='MaintenanceRequests']")


        For Each requestNode As XmlNode In requestNodes

            Dim row As DataRow = dt.NewRow()


            'Request ID

            row("RequestID") =
                Convert.ToInt32(
                    requestNode.SelectSingleNode(
                        "*[local-name()='RequestID']").InnerText)


            'User ID

            row("UserID") =
                Convert.ToInt32(
                    requestNode.SelectSingleNode(
                        "*[local-name()='UserID']").InnerText)


            'Category

            row("Category") =
                requestNode.SelectSingleNode(
                    "*[local-name()='Category']").InnerText


            'Location

            row("Location") =
                requestNode.SelectSingleNode(
                    "*[local-name()='Location']").InnerText


            'Description

            row("Description") =
                requestNode.SelectSingleNode(
                    "*[local-name()='Description']").InnerText


            'Date Reported

            row("DateReported") =
                Convert.ToDateTime(
                    requestNode.SelectSingleNode(
                        "*[local-name()='DateReported']").InnerText)


            'Status

            row("Status") =
                requestNode.SelectSingleNode(
                    "*[local-name()='Status']").InnerText


            'Assigned Staff ID

            Dim assignedNode As XmlNode =
                requestNode.SelectSingleNode(
                    "*[local-name()='AssignedStaffID']")


            If assignedNode Is Nothing OrElse
               assignedNode.InnerText = "" Then

                row("AssignedStaffID") =
                    DBNull.Value

            Else

                row("AssignedStaffID") =
                    Convert.ToInt32(
                        assignedNode.InnerText)

            End If


            dt.Rows.Add(row)

        Next


        Return dt

    End Function


    '=========================================================
    ' GRIDVIEW ROW DATA BOUND
    '=========================================================
    Protected Sub gvRequests_RowDataBound(
        ByVal sender As Object,
        ByVal e As GridViewRowEventArgs)


        If e.Row.RowType <> DataControlRowType.DataRow Then

            Return

        End If


        '=============================
        ' STATUS DROPDOWN
        '=============================

        Dim ddlStatus As DropDownList =
            CType(
                e.Row.FindControl("ddlStatus"), 
                DropDownList)


        Dim currentStatus As String =
            Convert.ToString(
                DataBinder.Eval(
                    e.Row.DataItem,
                    "Status"))


        If String.IsNullOrEmpty(currentStatus) Then

            currentStatus = "Pending"

        End If


        If ddlStatus.Items.FindByValue(
            currentStatus) IsNot Nothing Then

            ddlStatus.SelectedValue =
                currentStatus

        End If


        '=============================
        ' STAFF DROPDOWN
        '=============================

        Dim ddlStaff As DropDownList =
            CType(
                e.Row.FindControl("ddlStaff"), 
                DropDownList)


        ddlStaff.Items.Clear()


        ddlStaff.Items.Add(
            New ListItem(
                "Not Assigned",
                "0"))


        'Get request category

        Dim category As String =
            Convert.ToString(
                DataBinder.Eval(
                    e.Row.DataItem,
                    "Category"))


        Dim con As MySqlConnection =
            Nothing


        Try

            con =
                DBConnection.GetConnection()

            con.Open()


            'Show only staff belonging
            'to this request category

            Dim query As String =
                "SELECT StaffID, Name " &
                "FROM staff " &
                "WHERE Department = @Department " &
                "ORDER BY Name"


            Dim cmd As New MySqlCommand(
                query,
                con)


            cmd.Parameters.AddWithValue(
                "@Department",
                category)


            Dim reader As MySqlDataReader =
                cmd.ExecuteReader()


            While reader.Read()

                ddlStaff.Items.Add(
                    New ListItem(
                        reader("Name").ToString(),
                        reader("StaffID").ToString()))

            End While


            reader.Close()


            'Get currently assigned staff

            Dim assignedStaffID As String =
                Convert.ToString(
                    DataBinder.Eval(
                        e.Row.DataItem,
                        "AssignedStaffID"))


            If String.IsNullOrEmpty(
                assignedStaffID) Then

                assignedStaffID = "0"

            End If


            If ddlStaff.Items.FindByValue(
                assignedStaffID) IsNot Nothing Then

                ddlStaff.SelectedValue =
                    assignedStaffID

            End If


        Catch ex As Exception

            ddlStaff.Items.Clear()

            ddlStaff.Items.Add(
                New ListItem(
                    "Error loading staff",
                    "0"))


        Finally

            If con IsNot Nothing Then

                If con.State =
                    ConnectionState.Open Then

                    con.Close()

                End If

            End If

        End Try

    End Sub


    '=========================================================
    ' UPDATE REQUEST BUTTON
    '=========================================================
    Protected Sub gvRequests_RowCommand(
        ByVal sender As Object,
        ByVal e As GridViewCommandEventArgs)


        If e.CommandName <>
            "UpdateRequest" Then

            Return

        End If


        Try

            Dim requestID As Integer =
                Convert.ToInt32(
                    e.CommandArgument)


            Dim row As GridViewRow =
                CType(
                    CType(
                        e.CommandSource, 
                        Control).NamingContainer, 
                    GridViewRow)


            'Get status

            Dim ddlStatus As DropDownList =
                CType(
                    row.FindControl("ddlStatus"), 
                    DropDownList)


            Dim newStatus As String =
                ddlStatus.SelectedValue


            'Get staff

            Dim ddlStaff As DropDownList =
                CType(
                    row.FindControl("ddlStaff"), 
                    DropDownList)


            Dim staffID As Integer =
                Convert.ToInt32(
                    ddlStaff.SelectedValue)


            'Update database

            UpdateRequest(
                requestID,
                newStatus,
                staffID)


            lblMessage.CssClass =
                "message"


            lblMessage.Text =
                "Request #" &
                requestID.ToString() &
                " updated successfully."


            LoadRequests()


        Catch ex As Exception

            lblMessage.CssClass =
                "error"


            lblMessage.Text =
                "Error updating request: " &
                ex.Message

        End Try

    End Sub


    '=========================================================
    ' UPDATE REQUEST IN DATABASE
    '=========================================================
    Private Sub UpdateRequest(
        ByVal requestID As Integer,
        ByVal newStatus As String,
        ByVal staffID As Integer)


        Dim con As MySqlConnection =
            Nothing


        Try

            con =
                DBConnection.GetConnection()

            con.Open()


            Dim query As String =
                "UPDATE maintenancerequests " &
                "SET Status = @Status, " &
                "AssignedStaffID = @StaffID " &
                "WHERE RequestID = @RequestID"


            Dim cmd As New MySqlCommand(
                query,
                con)


            cmd.Parameters.AddWithValue(
                "@Status",
                newStatus)


            If staffID = 0 Then

                cmd.Parameters.AddWithValue(
                    "@StaffID",
                    DBNull.Value)

            Else

                cmd.Parameters.AddWithValue(
                    "@StaffID",
                    staffID)

            End If


            cmd.Parameters.AddWithValue(
                "@RequestID",
                requestID)


            cmd.ExecuteNonQuery()


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
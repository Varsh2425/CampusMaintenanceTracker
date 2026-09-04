Imports System
Imports System.Data
Imports System.Web.UI
Imports System.Web.UI.WebControls
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



    Private Sub LoadRequests()

        Dim con As MySqlConnection = Nothing

        Try

            con = DBConnection.GetConnection()

            con.Open()


            Dim query As String = _
                "SELECT RequestID, UserID, Category, Location, " & _
                "Description, DateReported, Status, AssignedStaffID " & _
                "FROM maintenancerequests " & _
                "ORDER BY RequestID DESC"


            Dim cmd As New MySqlCommand(query, con)

            Dim adapter As New MySqlDataAdapter(cmd)

            Dim dt As New DataTable()

            adapter.Fill(dt)


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
                "Error loading requests: " & ex.Message


        Finally

            If con IsNot Nothing Then

                If con.State = ConnectionState.Open Then

                    con.Close()

                End If

            End If

        End Try

    End Sub



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


        If ddlStatus.Items.FindByValue(currentStatus) IsNot Nothing Then

            ddlStatus.SelectedValue = currentStatus

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



        Dim con As MySqlConnection = Nothing


        Try

            con = DBConnection.GetConnection()

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


            If String.IsNullOrEmpty(assignedStaffID) Then

                assignedStaffID = "0"

            End If


            If ddlStaff.Items.FindByValue(assignedStaffID) IsNot Nothing Then

                ddlStaff.SelectedValue = assignedStaffID

            End If


        Catch ex As Exception

            ddlStaff.Items.Clear()

            ddlStaff.Items.Add(
                New ListItem(
                    "Error loading staff",
                    "0"))


        Finally

            If con IsNot Nothing Then

                If con.State = ConnectionState.Open Then

                    con.Close()

                End If

            End If

        End Try

    End Sub



    Protected Sub gvRequests_RowCommand(
        ByVal sender As Object,
        ByVal e As GridViewCommandEventArgs)


        If e.CommandName <> "UpdateRequest" Then

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


            lblMessage.CssClass = "message"

            lblMessage.Text =
                "Request #" &
                requestID.ToString() &
                " updated successfully."


            LoadRequests()


        Catch ex As Exception

            lblMessage.CssClass = "error"

            lblMessage.Text =
                "Error updating request: " &
                ex.Message

        End Try

    End Sub



    Private Sub UpdateRequest(
        ByVal requestID As Integer,
        ByVal newStatus As String,
        ByVal staffID As Integer)


        Dim con As MySqlConnection = Nothing


        Try

            con = DBConnection.GetConnection()

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

                If con.State = ConnectionState.Open Then

                    con.Close()

                End If

            End If

        End Try

    End Sub


End Class
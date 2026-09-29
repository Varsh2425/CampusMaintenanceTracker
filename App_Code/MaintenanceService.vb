Imports System
Imports System.Data
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports MySql.Data.MySqlClient

<WebService(Namespace:="http://campusmaintenancetracker/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class MaintenanceService
    Inherits System.Web.Services.WebService

    '=========================================================
    ' 1. GET ALL MAINTENANCE REQUESTS
    '=========================================================
    <WebMethod()> _
    Public Function GetAllRequests() As DataTable

        Dim dt As New DataTable()
        dt.TableName = "MaintenanceRequests"

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

            adapter.Fill(dt)

        Catch ex As Exception

            Throw New Exception( _
                "Error retrieving maintenance requests: " & ex.Message)

        Finally

            If con IsNot Nothing Then

                If con.State = ConnectionState.Open Then
                    con.Close()
                End If

            End If

        End Try

        Return dt

    End Function


    '=========================================================
    ' 2. GET A PARTICULAR REQUEST BY REQUEST ID
    '=========================================================
    <WebMethod()> _
    Public Function GetRequestById(ByVal requestId As Integer) As DataTable

        Dim dt As New DataTable()
        dt.TableName = "MaintenanceRequest"

        Dim con As MySqlConnection = Nothing

        Try

            con = DBConnection.GetConnection()
            con.Open()

            Dim query As String = _
                "SELECT RequestID, UserID, Category, Location, " & _
                "Description, DateReported, Status, AssignedStaffID " & _
                "FROM maintenancerequests " & _
                "WHERE RequestID = @RequestID"

            Dim cmd As New MySqlCommand(query, con)

            cmd.Parameters.AddWithValue("@RequestID", requestId)

            Dim adapter As New MySqlDataAdapter(cmd)

            adapter.Fill(dt)

        Catch ex As Exception

            Throw New Exception( _
                "Error retrieving request: " & ex.Message)

        Finally

            If con IsNot Nothing Then

                If con.State = ConnectionState.Open Then
                    con.Close()
                End If

            End If

        End Try

        Return dt

    End Function


    '=========================================================
    ' 3. GET REQUESTS SUBMITTED BY A PARTICULAR USER
    '=========================================================
    <WebMethod()> _
    Public Function GetRequestsByUser(ByVal userId As Integer) As DataTable

        Dim dt As New DataTable()
        dt.TableName = "UserMaintenanceRequests"

        Dim con As MySqlConnection = Nothing

        Try

            con = DBConnection.GetConnection()
            con.Open()

            Dim query As String = _
                "SELECT RequestID, UserID, Category, Location, " & _
                "Description, DateReported, Status, AssignedStaffID " & _
                "FROM maintenancerequests " & _
                "WHERE UserID = @UserID " & _
                "ORDER BY RequestID DESC"

            Dim cmd As New MySqlCommand(query, con)

            cmd.Parameters.AddWithValue("@UserID", userId)

            Dim adapter As New MySqlDataAdapter(cmd)

            adapter.Fill(dt)

        Catch ex As Exception

            Throw New Exception( _
                "Error retrieving user requests: " & ex.Message)

        Finally

            If con IsNot Nothing Then

                If con.State = ConnectionState.Open Then
                    con.Close()
                End If

            End If

        End Try

        Return dt

    End Function


    '=========================================================
    ' 4. GET REQUESTS BY STATUS
    '=========================================================
    <WebMethod()> _
    Public Function GetRequestsByStatus(ByVal status As String) As DataTable

        Dim dt As New DataTable()
        dt.TableName = "StatusMaintenanceRequests"

        Dim con As MySqlConnection = Nothing

        Try

            con = DBConnection.GetConnection()
            con.Open()

            Dim query As String = _
                "SELECT RequestID, UserID, Category, Location, " & _
                "Description, DateReported, Status, AssignedStaffID " & _
                "FROM maintenancerequests " & _
                "WHERE Status = @Status " & _
                "ORDER BY RequestID DESC"

            Dim cmd As New MySqlCommand(query, con)

            cmd.Parameters.AddWithValue("@Status", status)

            Dim adapter As New MySqlDataAdapter(cmd)

            adapter.Fill(dt)

        Catch ex As Exception

            Throw New Exception( _
                "Error retrieving requests by status: " & ex.Message)

        Finally

            If con IsNot Nothing Then

                If con.State = ConnectionState.Open Then
                    con.Close()
                End If

            End If

        End Try

        Return dt

    End Function


    '=========================================================
    ' 5. GET ALL STAFF
    '=========================================================
    <WebMethod()> _
    Public Function GetStaff() As DataTable

        Dim dt As New DataTable()
        dt.TableName = "Staff"

        Dim con As MySqlConnection = Nothing

        Try

            con = DBConnection.GetConnection()
            con.Open()

            Dim query As String = _
                "SELECT StaffID, Name, Department, Contact, UserID " & _
                "FROM staff " & _
                "ORDER BY Name"

            Dim cmd As New MySqlCommand(query, con)

            Dim adapter As New MySqlDataAdapter(cmd)

            adapter.Fill(dt)

        Catch ex As Exception

            Throw New Exception( _
                "Error retrieving staff: " & ex.Message)

        Finally

            If con IsNot Nothing Then

                If con.State = ConnectionState.Open Then
                    con.Close()
                End If

            End If

        End Try

        Return dt

    End Function

End Class
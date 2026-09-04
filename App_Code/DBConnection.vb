Imports System
Imports System.Configuration
Imports MySql.Data.MySqlClient

Public Class DBConnection

    Private Shared connectionString As String = _
        ConfigurationManager.ConnectionStrings("CampusDB").ConnectionString

    Public Shared Function GetConnection() As MySqlConnection
        Return New MySqlConnection(connectionString)
    End Function

End Class

Imports System
Imports System.Data.SQLite

Namespace Runtime
    Public NotInheritable Class SQLiteRuntimeProbe
        Public Const PinnedProviderVersion As String = "1.0.119"

        Public Function Execute(connectionString As String) As String
            If String.IsNullOrWhiteSpace(connectionString) Then
                Throw New ArgumentException("Connection string is required.", NameOf(connectionString))
            End If

            Using connection As New SQLiteConnection(connectionString)
                connection.Open()
                Using command As SQLiteCommand = connection.CreateCommand()
                    command.CommandText = "select sqlite_version();"
                    Return Convert.ToString(command.ExecuteScalar(), Globalization.CultureInfo.InvariantCulture)
                End Using
            End Using
        End Function
    End Class
End Namespace

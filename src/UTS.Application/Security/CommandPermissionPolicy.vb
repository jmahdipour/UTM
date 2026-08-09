Imports System

Namespace Security
    Public NotInheritable Class CommandPermissionPolicy
        Public Function RequiresPermission(commandType As String) As Boolean
            If String.IsNullOrWhiteSpace(commandType) Then
                Throw New ArgumentException("Command type is required.", NameOf(commandType))
            End If

            Return Not StringComparer.Ordinal.Equals(commandType, "MAC.END_JOG") AndAlso
                   Not StringComparer.Ordinal.Equals(commandType, "RUN.STOP")
        End Function
    End Class
End Namespace

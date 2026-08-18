Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Namespace Shell
    Public NotInheritable Class ShellViewModel
        Private Shared ReadOnly FrozenPages As IReadOnlyList(Of String) =
            New ReadOnlyCollection(Of String)(New List(Of String) From {
                "Reception",
                "Test",
                "Method",
                "Calibration",
                "Settings",
                "Report"
            })

        Public ReadOnly Property ApplicationTitle As String = "Universal Testing Machine"
        Public ReadOnly Property BaselineStatus As String = "Implementation baseline — Simulator only"
        Public ReadOnly Property SafetyStatus As String = "Physical motion BLOCKED-HARDWARE"
        Public ReadOnly Property Pages As IReadOnlyList(Of String) = FrozenPages
    End Class
End Namespace

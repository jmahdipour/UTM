Namespace Activation
    Public Enum AdapterMode
        Simulator = 1
        PhysicalMonitorOnly = 2
        PhysicalCommissioning = 3
        PhysicalProduction = 4
    End Enum

    Public NotInheritable Class AdapterActivation
        Public Sub New(mode As AdapterMode, physicalWritesEnabled As Boolean)
            If Not [Enum].IsDefined(GetType(AdapterMode), mode) Then
                Throw New ArgumentOutOfRangeException(NameOf(mode))
            End If

            If (mode = AdapterMode.Simulator OrElse mode = AdapterMode.PhysicalMonitorOnly) AndAlso physicalWritesEnabled Then
                Throw New ArgumentException("Simulator and monitor-only modes cannot enable physical writes.", NameOf(physicalWritesEnabled))
            End If

            Me.Mode = mode
            Me.PhysicalWritesEnabled = physicalWritesEnabled
        End Sub

        Public ReadOnly Property Mode As AdapterMode
        Public ReadOnly Property PhysicalWritesEnabled As Boolean

        Public Shared Function CreateCurrentBaseline() As AdapterActivation
            Return New AdapterActivation(AdapterMode.Simulator, False)
        End Function
    End Class
End Namespace

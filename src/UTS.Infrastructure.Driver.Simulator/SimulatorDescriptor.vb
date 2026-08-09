Imports UTS.Infrastructure.Driver.Abstractions.Activation

Namespace Configuration
    Public NotInheritable Class SimulatorDescriptor
        Public ReadOnly Property AdapterIdentity As String = "UTS.DeterministicSimulator"
        Public ReadOnly Property ContractVersion As Integer = 1
        Public ReadOnly Property Activation As AdapterActivation = AdapterActivation.CreateCurrentBaseline()
        Public ReadOnly Property ProductionEvidencePermitted As Boolean = False
    End Class
End Namespace

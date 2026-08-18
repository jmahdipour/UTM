Imports UTS.Infrastructure.Driver.Abstractions.Activation
Imports UTS.Presentation.Wpf.Shell

Namespace Composition
    Public NotInheritable Class CompositionRoot
        Private ReadOnly _adapterActivation As AdapterActivation

        Public Sub New()
            _adapterActivation = AdapterActivation.CreateCurrentBaseline()
        End Sub

        Public Function CreateShellWindow() As ShellWindow
            If _adapterActivation.Mode <> AdapterMode.Simulator OrElse _adapterActivation.PhysicalWritesEnabled Then
                Throw New InvalidOperationException("The current controlled baseline permits the Simulator with physical writes disabled only.")
            End If

            Return New ShellWindow(New ShellViewModel())
        End Function
    End Class
End Namespace

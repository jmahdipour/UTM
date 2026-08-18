Imports System.Windows

Namespace Shell
    Public Partial Class ShellWindow
        Inherits Window

        Public Sub New(viewModel As ShellViewModel)
            If viewModel Is Nothing Then Throw New ArgumentNullException(NameOf(viewModel))
            InitializeComponent()
            DataContext = viewModel
        End Sub
    End Class
End Namespace

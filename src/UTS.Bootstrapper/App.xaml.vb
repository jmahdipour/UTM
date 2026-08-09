Imports System.Windows
Imports UTS.Bootstrapper.Composition

Public Partial Class App
    Inherits System.Windows.Application

    Protected Overrides Sub OnStartup(e As StartupEventArgs)
        MyBase.OnStartup(e)
        Dim root As New CompositionRoot()
        MainWindow = root.CreateShellWindow()
        MainWindow.Show()
    End Sub
End Class

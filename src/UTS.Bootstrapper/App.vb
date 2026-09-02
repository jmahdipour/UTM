Imports System
Imports System.Windows
Imports UTS.Bootstrapper.Composition

''' <summary>
''' Application entry point, built entirely in code (no App.xaml).
''' </summary>
''' <remarks>
''' Deliberate implementation choice, not a design change: paired with
''' Shell/ShellWindow.vb's removal of ShellWindow.xaml, for the same reason -
''' the XAML markup compiler failed to reliably generate the InitializeComponent
''' partial-class member for VB.NET SDK-style WPF projects on the reported
''' toolchain. Removing App.xaml also removes the markup compiler's
''' auto-generated Shared Sub Main, so it is declared explicitly here instead.
''' Revisit XAML once a known-good SDK/toolchain is confirmed to build it; see
''' ROADMAP.md Milestone 11. The base class is fully qualified
''' (System.Windows.Application) rather than
''' the bare 'Application' from the 'Imports System.Windows' below: this
''' solution also references a project named exactly 'UTS.Application'
''' (RootNamespace 'UTS.Application'). VB.NET's unqualified-name lookup checks
''' enclosing namespaces (UTS.Bootstrapper -> UTS -> global) before it
''' considers Imports statements, and at the 'UTS' level it finds the
''' namespace 'UTS.Application' and resolves the bare word 'Application' to
''' that namespace instead of System.Windows.Application - producing
''' 'BC30182: Type expected' since a namespace cannot appear in an Inherits
''' clause. Fully qualifying sidesteps the ambiguity entirely.
''' </remarks>
Public NotInheritable Class App
    Inherits System.Windows.Application

    <STAThread>
    Public Shared Sub Main()
        Dim application As New App()
        application.Run()
    End Sub

    Protected Overrides Sub OnStartup(e As StartupEventArgs)
        MyBase.OnStartup(e)
        Dim root As New CompositionRoot()
        MainWindow = root.CreateShellWindow()
        MainWindow.Show()
    End Sub
End Class

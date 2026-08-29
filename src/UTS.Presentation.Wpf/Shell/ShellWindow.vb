Imports System
Imports System.Windows
Imports System.Windows.Controls
Imports System.Windows.Controls.Primitives
Imports System.Windows.Data
Imports System.Windows.Media

Namespace Shell

    ''' <summary>
    ''' Six-workspace shell window per EDR-0006, built entirely in code (no XAML).
    ''' </summary>
    ''' <remarks>
    ''' Deliberate implementation choice, not a design change: the XAML markup
    ''' compiler failed to reliably generate the partial-class InitializeComponent
    ''' member for VB.NET SDK-style WPF projects on the reported toolchain
    ''' (.NET 5 SDK). Rather than continue patching project-file metadata blind
    ''' (no Windows/WPF build environment is available in this session to verify
    ''' a fix), the window is built with the plain WPF object model plus
    ''' programmatic System.Windows.Data.Binding objects. This preserves true
    ''' MVVM data binding to ShellViewModel and keeps the same visible layout as
    ''' the removed ShellWindow.xaml, without depending on the markup compiler
    ''' pipeline at all. Revisit XAML once a known-good SDK/toolchain is
    ''' confirmed to build it; see ROADMAP.md Milestone 11.
    ''' </remarks>
    Public NotInheritable Class ShellWindow
        Inherits Window

        Public Sub New(viewModel As ShellViewModel)
            If viewModel Is Nothing Then Throw New ArgumentNullException(NameOf(viewModel))

            DataContext = viewModel
            Width = 1280
            Height = 800
            MinWidth = 1024
            MinHeight = 640
            WindowStartupLocation = WindowStartupLocation.CenterScreen
            SetBinding(TitleProperty, New Binding(NameOf(ShellViewModel.ApplicationTitle)))

            Content = BuildLayout()
        End Sub

        Private Shared Function BuildLayout() As UIElement
            Dim root As New Grid()
            root.Background = BrushFromHex("#F2F4F7")
            root.RowDefinitions.Add(New RowDefinition() With {.Height = GridLength.Auto})
            root.RowDefinitions.Add(New RowDefinition() With {.Height = GridLength.Auto})
            root.RowDefinitions.Add(New RowDefinition() With {.Height = New GridLength(1, GridUnitType.Star)})
            root.RowDefinitions.Add(New RowDefinition() With {.Height = GridLength.Auto})

            Dim header As UIElement = BuildHeader()
            Grid.SetRow(header, 0)
            root.Children.Add(header)

            Dim safetyBanner As UIElement = BuildSafetyBanner()
            Grid.SetRow(safetyBanner, 1)
            root.Children.Add(safetyBanner)

            Dim body As UIElement = BuildBody()
            Grid.SetRow(body, 2)
            root.Children.Add(body)

            Dim statusBar As UIElement = BuildStatusBar()
            Grid.SetRow(statusBar, 3)
            root.Children.Add(statusBar)

            Return root
        End Function

        Private Shared Function BuildHeader() As UIElement
            Dim border As New Border() With {
                .Background = BrushFromHex("#17324D"),
                .Padding = New Thickness(20, 14, 20, 14)
            }

            Dim panel As New DockPanel()

            Dim title As New TextBlock() With {
                .Foreground = Brushes.White,
                .FontSize = 24,
                .FontWeight = FontWeights.SemiBold
            }
            title.SetBinding(TextBlock.TextProperty, New Binding(NameOf(ShellViewModel.ApplicationTitle)))
            panel.Children.Add(title)

            Dim baseline As New TextBlock() With {
                .Foreground = BrushFromHex("#DCE7F2"),
                .FontSize = 14,
                .HorizontalAlignment = HorizontalAlignment.Right,
                .VerticalAlignment = VerticalAlignment.Center
            }
            baseline.SetBinding(TextBlock.TextProperty, New Binding(NameOf(ShellViewModel.BaselineStatus)))
            DockPanel.SetDock(baseline, Dock.Right)
            panel.Children.Add(baseline)

            border.Child = panel
            Return border
        End Function

        Private Shared Function BuildSafetyBanner() As UIElement
            Dim border As New Border() With {
                .Background = BrushFromHex("#FFF3CD"),
                .BorderBrush = BrushFromHex("#E0A800"),
                .BorderThickness = New Thickness(0, 0, 0, 1),
                .Padding = New Thickness(16, 8, 16, 8)
            }

            Dim text As New TextBlock() With {
                .Foreground = BrushFromHex("#7A4E00"),
                .FontWeight = FontWeights.Bold
            }
            text.SetBinding(TextBlock.TextProperty, New Binding(NameOf(ShellViewModel.SafetyStatus)))

            border.Child = text
            Return border
        End Function

        Private Shared Function BuildBody() As UIElement
            Dim grid As New Grid()
            grid.ColumnDefinitions.Add(New ColumnDefinition() With {.Width = New GridLength(220)})
            grid.ColumnDefinitions.Add(New ColumnDefinition() With {.Width = New GridLength(1, GridUnitType.Star)})

            Dim navigation As UIElement = BuildNavigation()
            Grid.SetColumn(navigation, 0)
            grid.Children.Add(navigation)

            Dim placeholder As UIElement = BuildPlaceholder()
            Grid.SetColumn(placeholder, 1)
            grid.Children.Add(placeholder)

            Return grid
        End Function

        Private Shared Function BuildNavigation() As UIElement
            Dim border As New Border() With {
                .Background = Brushes.White,
                .BorderBrush = BrushFromHex("#D8DEE6"),
                .BorderThickness = New Thickness(0, 0, 1, 0),
                .Padding = New Thickness(12)
            }

            Dim itemsControl As New ItemsControl()
            itemsControl.SetBinding(ItemsControl.ItemsSourceProperty, New Binding(NameOf(ShellViewModel.Pages)))

            Dim template As New DataTemplate()
            Dim buttonFactory As New FrameworkElementFactory(GetType(Button))
            buttonFactory.SetBinding(ContentControl.ContentProperty, New Binding())
            buttonFactory.SetValue(FrameworkElement.HeightProperty, 44.0R)
            buttonFactory.SetValue(FrameworkElement.MarginProperty, New Thickness(0, 0, 0, 8))
            buttonFactory.SetValue(Control.HorizontalContentAlignmentProperty, HorizontalAlignment.Left)
            buttonFactory.SetValue(Control.PaddingProperty, New Thickness(14, 0, 14, 0))
            buttonFactory.SetValue(Button.IsEnabledProperty, False)
            template.VisualTree = buttonFactory
            itemsControl.ItemTemplate = template

            border.Child = itemsControl
            Return border
        End Function

        Private Shared Function BuildPlaceholder() As UIElement
            Dim border As New Border() With {
                .Margin = New Thickness(24),
                .Background = Brushes.White,
                .BorderBrush = BrushFromHex("#D8DEE6"),
                .BorderThickness = New Thickness(1),
                .CornerRadius = New CornerRadius(4),
                .Padding = New Thickness(32)
            }

            Dim stack As New StackPanel() With {
                .HorizontalAlignment = HorizontalAlignment.Center,
                .VerticalAlignment = VerticalAlignment.Center
            }

            stack.Children.Add(New TextBlock() With {
                .Text = "UTS Solution Foundation",
                .FontSize = 30,
                .FontWeight = FontWeights.SemiBold,
                .Foreground = BrushFromHex("#17324D"),
                .HorizontalAlignment = HorizontalAlignment.Center
            })

            stack.Children.Add(New TextBlock() With {
                .Text = "Architecture boundaries, contracts and validation gates are active.",
                .Margin = New Thickness(0, 12, 0, 0),
                .FontSize = 16,
                .Foreground = BrushFromHex("#536273"),
                .TextAlignment = TextAlignment.Center
            })

            border.Child = stack
            Return border
        End Function

        Private Shared Function BuildStatusBar() As UIElement
            Dim statusBar As New StatusBar()
            statusBar.Items.Add(New StatusBarItem() With {
                .Content = "VB.NET " & ChrW(&H2022) & " .NET Framework 4.8 " & ChrW(&H2022) & " x86 " & ChrW(&H2022) & " WPF/MVVM " & ChrW(&H2022) & " SQLite"
            })
            Return statusBar
        End Function

        Private Shared Function BrushFromHex(hex As String) As SolidColorBrush
            Dim brush As SolidColorBrush = CType(New BrushConverter().ConvertFromString(hex), SolidColorBrush)
            brush.Freeze()
            Return brush
        End Function

    End Class

End Namespace

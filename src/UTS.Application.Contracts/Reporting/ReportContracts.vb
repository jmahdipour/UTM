Imports System
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Threading
Imports System.Threading.Tasks
Imports UTS.Core.Common

Namespace Reporting
    Public Enum ReportFormat
        Csv = 1
        Pdf = 2
    End Enum

    Public NotInheritable Class ReportInputBundle
        Public Sub New(bundleId As CanonicalId,
                       runId As CanonicalId,
                       analysisRevisionId As CanonicalId,
                       templateRevisionId As CanonicalId,
                       inputHash As String,
                       values As IEnumerable(Of KeyValuePair(Of String, String)),
                       isSimulator As Boolean)
            If bundleId Is Nothing Then Throw New ArgumentNullException(NameOf(bundleId))
            If runId Is Nothing Then Throw New ArgumentNullException(NameOf(runId))
            If analysisRevisionId Is Nothing Then Throw New ArgumentNullException(NameOf(analysisRevisionId))
            If templateRevisionId Is Nothing Then Throw New ArgumentNullException(NameOf(templateRevisionId))
            If String.IsNullOrWhiteSpace(inputHash) Then Throw New ArgumentException("Input hash is required.", NameOf(inputHash))
            If values Is Nothing Then Throw New ArgumentNullException(NameOf(values))
            Me.BundleId = bundleId
            Me.RunId = runId
            Me.AnalysisRevisionId = analysisRevisionId
            Me.TemplateRevisionId = templateRevisionId
            Me.InputHash = inputHash
            Me.Values = New ReadOnlyCollection(Of KeyValuePair(Of String, String))(New List(Of KeyValuePair(Of String, String))(values))
            Me.IsSimulator = isSimulator
        End Sub

        Public ReadOnly Property BundleId As CanonicalId
        Public ReadOnly Property RunId As CanonicalId
        Public ReadOnly Property AnalysisRevisionId As CanonicalId
        Public ReadOnly Property TemplateRevisionId As CanonicalId
        Public ReadOnly Property InputHash As String
        Public ReadOnly Property Values As IReadOnlyList(Of KeyValuePair(Of String, String))
        Public ReadOnly Property IsSimulator As Boolean
    End Class

    Public NotInheritable Class ReportArtifactDraft
        Private ReadOnly _content As Byte()

        Public Sub New(format As ReportFormat, mediaType As String, content As Byte(), isNonProduction As Boolean)
            If Not [Enum].IsDefined(GetType(ReportFormat), format) Then Throw New ArgumentOutOfRangeException(NameOf(format))
            If String.IsNullOrWhiteSpace(mediaType) Then Throw New ArgumentException("Media type is required.", NameOf(mediaType))
            If content Is Nothing OrElse content.Length = 0 Then Throw New ArgumentException("Artifact content is required.", NameOf(content))
            Me.Format = format
            Me.MediaType = mediaType
            _content = DirectCast(content.Clone(), Byte())
            Me.IsNonProduction = isNonProduction
        End Sub

        Public ReadOnly Property Format As ReportFormat
        Public ReadOnly Property MediaType As String
        Public ReadOnly Property Content As Byte()
            Get
                Return DirectCast(_content.Clone(), Byte())
            End Get
        End Property
        Public ReadOnly Property IsNonProduction As Boolean
    End Class

    Public Interface IReportRenderer
        Function RenderAsync(input As ReportInputBundle, format As ReportFormat, cancellationToken As CancellationToken) As Task(Of ReportArtifactDraft)
    End Interface
End Namespace

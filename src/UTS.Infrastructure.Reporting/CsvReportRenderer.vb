Imports System
Imports System.Linq
Imports System.Text
Imports System.Threading
Imports System.Threading.Tasks
Imports UTS.Application.Contracts.Reporting

Namespace Csv
    Public NotInheritable Class CsvReportRenderer
        Implements IReportRenderer

        Public Function RenderAsync(input As ReportInputBundle,
                                    format As ReportFormat,
                                    cancellationToken As CancellationToken) As Task(Of ReportArtifactDraft) Implements IReportRenderer.RenderAsync
            If input Is Nothing Then Throw New ArgumentNullException(NameOf(input))
            If format <> ReportFormat.Csv Then Throw New NotSupportedException("This renderer supports the governed CSV format only.")
            cancellationToken.ThrowIfCancellationRequested()

            Dim builder As New StringBuilder()
            builder.AppendLine("schema,uts.report.csv.v1")
            builder.Append("input_hash,").AppendLine(Escape(input.InputHash))
            builder.Append("run_id,").AppendLine(Escape(input.RunId.Value))
            builder.Append("analysis_revision_id,").AppendLine(Escape(input.AnalysisRevisionId.Value))
            builder.Append("classification,").AppendLine(If(input.IsSimulator, "NON-PRODUCTION - SIMULATED DATA", "CONTROLLED DATA EXPORT"))
            builder.AppendLine("field,value")

            For Each item In input.Values.OrderBy(Function(pair) pair.Key, StringComparer.Ordinal)
                cancellationToken.ThrowIfCancellationRequested()
                builder.Append(Escape(item.Key)).Append(",").AppendLine(Escape(item.Value))
            Next

            Dim bytes As Byte() = New UTF8Encoding(False).GetBytes(builder.ToString())
            Dim artifact As New ReportArtifactDraft(ReportFormat.Csv, "text/csv; charset=utf-8", bytes, input.IsSimulator)
            Return Task.FromResult(artifact)
        End Function

        Private Shared Function Escape(value As String) As String
            Dim safeValue As String = If(value, String.Empty)
            If safeValue.IndexOfAny(New Char() {","c, ControlChars.Quote, ControlChars.Cr, ControlChars.Lf}) >= 0 Then
                Dim quote As String = ControlChars.Quote.ToString()
                Return quote & safeValue.Replace(quote, New String(ControlChars.Quote, 2)) & quote
            End If

            Return safeValue
        End Function
    End Class
End Namespace

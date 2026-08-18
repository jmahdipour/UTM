Imports System
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Namespace Queries
    Public NotInheritable Class QueryResult(Of TProjection)
        Public Sub New(contractVersion As Integer,
                       projectionVersion As Long,
                       generatedAtUtc As DateTimeOffset,
                       data As TProjection,
                       Optional warnings As IEnumerable(Of String) = Nothing)
            If contractVersion <= 0 Then Throw New ArgumentOutOfRangeException(NameOf(contractVersion))
            If projectionVersion < 0 Then Throw New ArgumentOutOfRangeException(NameOf(projectionVersion))
            If generatedAtUtc.Offset <> TimeSpan.Zero Then Throw New ArgumentException("Query time must be UTC.", NameOf(generatedAtUtc))
            If DirectCast(data, Object) Is Nothing Then Throw New ArgumentNullException(NameOf(data))

            Me.ContractVersion = contractVersion
            Me.ProjectionVersion = projectionVersion
            Me.GeneratedAtUtc = generatedAtUtc
            Me.Data = data
            Me.Warnings = New ReadOnlyCollection(Of String)(New List(Of String)(If(warnings, Array.Empty(Of String)())))
        End Sub

        Public ReadOnly Property ContractVersion As Integer
        Public ReadOnly Property ProjectionVersion As Long
        Public ReadOnly Property GeneratedAtUtc As DateTimeOffset
        Public ReadOnly Property Data As TProjection
        Public ReadOnly Property Warnings As IReadOnlyList(Of String)
    End Class
End Namespace

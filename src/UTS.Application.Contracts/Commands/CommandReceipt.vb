Imports System
Imports UTS.Core.Common

Namespace Commands
    Public NotInheritable Class CommandReceipt
        Public Sub New(requestId As CanonicalId,
                       correlationId As CanonicalId,
                       outcome As CommandOutcome,
                       reasonCode As String,
                       recordedAtUtc As DateTimeOffset,
                       Optional operationId As CanonicalId = Nothing,
                       Optional aggregateId As CanonicalId = Nothing,
                       Optional aggregateRevision As Long? = Nothing)
            If requestId Is Nothing Then Throw New ArgumentNullException(NameOf(requestId))
            If correlationId Is Nothing Then Throw New ArgumentNullException(NameOf(correlationId))
            If Not [Enum].IsDefined(GetType(CommandOutcome), outcome) Then Throw New ArgumentOutOfRangeException(NameOf(outcome))
            If String.IsNullOrWhiteSpace(reasonCode) Then Throw New ArgumentException("A stable reason code is required.", NameOf(reasonCode))
            If recordedAtUtc.Offset <> TimeSpan.Zero Then Throw New ArgumentException("Receipt time must be UTC.", NameOf(recordedAtUtc))
            If aggregateRevision.HasValue AndAlso aggregateRevision.Value < 0 Then Throw New ArgumentOutOfRangeException(NameOf(aggregateRevision))

            Me.RequestId = requestId
            Me.CorrelationId = correlationId
            Me.Outcome = outcome
            Me.ReasonCode = reasonCode
            Me.RecordedAtUtc = recordedAtUtc
            Me.OperationId = operationId
            Me.AggregateId = aggregateId
            Me.AggregateRevision = aggregateRevision
        End Sub

        Public ReadOnly Property RequestId As CanonicalId
        Public ReadOnly Property CorrelationId As CanonicalId
        Public ReadOnly Property OperationId As CanonicalId
        Public ReadOnly Property Outcome As CommandOutcome
        Public ReadOnly Property ReasonCode As String
        Public ReadOnly Property AggregateId As CanonicalId
        Public ReadOnly Property AggregateRevision As Long?
        Public ReadOnly Property RecordedAtUtc As DateTimeOffset
    End Class
End Namespace

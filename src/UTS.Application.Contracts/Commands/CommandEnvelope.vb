Imports System
Imports UTS.Core.Common

Namespace Commands
    Public NotInheritable Class CommandEnvelope(Of TPayload)
        Public Sub New(requestId As CanonicalId,
                       commandType As String,
                       schemaVersion As Integer,
                       correlationId As CanonicalId,
                       requestedAtUtc As DateTimeOffset,
                       actorSessionId As CanonicalId,
                       payload As TPayload,
                       Optional aggregateId As CanonicalId = Nothing,
                       Optional expectedRevision As Long? = Nothing,
                       Optional causationId As CanonicalId = Nothing)
            If requestId Is Nothing Then Throw New ArgumentNullException(NameOf(requestId))
            If String.IsNullOrWhiteSpace(commandType) Then Throw New ArgumentException("Command type is required.", NameOf(commandType))
            If schemaVersion <= 0 Then Throw New ArgumentOutOfRangeException(NameOf(schemaVersion))
            If correlationId Is Nothing Then Throw New ArgumentNullException(NameOf(correlationId))
            If requestedAtUtc.Offset <> TimeSpan.Zero Then Throw New ArgumentException("Command time must be normalized to UTC.", NameOf(requestedAtUtc))
            If actorSessionId Is Nothing Then Throw New ArgumentNullException(NameOf(actorSessionId))
            If DirectCast(payload, Object) Is Nothing Then Throw New ArgumentNullException(NameOf(payload))
            If expectedRevision.HasValue AndAlso expectedRevision.Value < 0 Then Throw New ArgumentOutOfRangeException(NameOf(expectedRevision))

            Me.RequestId = requestId
            Me.CommandType = commandType
            Me.SchemaVersion = schemaVersion
            Me.CorrelationId = correlationId
            Me.RequestedAtUtc = requestedAtUtc
            Me.ActorSessionId = actorSessionId
            Me.Payload = payload
            Me.AggregateId = aggregateId
            Me.ExpectedRevision = expectedRevision
            Me.CausationId = causationId
        End Sub

        Public ReadOnly Property RequestId As CanonicalId
        Public ReadOnly Property CommandType As String
        Public ReadOnly Property SchemaVersion As Integer
        Public ReadOnly Property CorrelationId As CanonicalId
        Public ReadOnly Property CausationId As CanonicalId
        Public ReadOnly Property RequestedAtUtc As DateTimeOffset
        Public ReadOnly Property ActorSessionId As CanonicalId
        Public ReadOnly Property AggregateId As CanonicalId
        Public ReadOnly Property ExpectedRevision As Long?
        Public ReadOnly Property Payload As TPayload
    End Class
End Namespace

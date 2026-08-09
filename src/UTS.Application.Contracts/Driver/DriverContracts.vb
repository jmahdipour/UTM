Imports System
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Threading
Imports System.Threading.Tasks
Imports UTS.Core.Common
Imports UTS.Core.Measurement
Imports UTS.Core.Units

Namespace Driver
    Public Enum DriverConnectionState
        Disconnected = 0
        Connecting = 1
        Handshaking = 2
        Monitoring = 3
        CommandReady = 4
        Degraded = 5
        ReconciliationRequired = 6
        DriverFaulted = 7
    End Enum

    Public Enum DriverCommandKind
        RequestControlledStop = 1
        BeginJog = 2
        RenewJog = 3
        EndJog = 4
        ArmProgram = 5
        StartProgram = 6
        HoldProgram = 7
        ResumeProgram = 8
        ApplyZeroTare = 9
    End Enum

    Public Enum DriverCommandStatus
        Acknowledged = 1
        Rejected = 2
        TimedOut = 3
        Failed = 4
    End Enum

    Public NotInheritable Class DriverConnectRequest
        Public Sub New(machineId As CanonicalId, profileHash As String)
            If machineId Is Nothing Then Throw New ArgumentNullException(NameOf(machineId))
            If String.IsNullOrWhiteSpace(profileHash) Then Throw New ArgumentException("Profile hash is required.", NameOf(profileHash))
            Me.MachineId = machineId
            Me.ProfileHash = profileHash
        End Sub

        Public ReadOnly Property MachineId As CanonicalId
        Public ReadOnly Property ProfileHash As String
    End Class

    Public NotInheritable Class DriverConnectReceipt
        Public Sub New(sessionId As CanonicalId, state As DriverConnectionState, reasonCode As String)
            If sessionId Is Nothing Then Throw New ArgumentNullException(NameOf(sessionId))
            If Not [Enum].IsDefined(GetType(DriverConnectionState), state) Then Throw New ArgumentOutOfRangeException(NameOf(state))
            If String.IsNullOrWhiteSpace(reasonCode) Then Throw New ArgumentException("Reason code is required.", NameOf(reasonCode))
            Me.SessionId = sessionId
            Me.State = state
            Me.ReasonCode = reasonCode
        End Sub

        Public ReadOnly Property SessionId As CanonicalId
        Public ReadOnly Property State As DriverConnectionState
        Public ReadOnly Property ReasonCode As String
    End Class

    Public NotInheritable Class DriverCapabilities
        Public Sub New(sessionId As CanonicalId, commandKinds As IEnumerable(Of DriverCommandKind))
            If sessionId Is Nothing Then Throw New ArgumentNullException(NameOf(sessionId))
            If commandKinds Is Nothing Then Throw New ArgumentNullException(NameOf(commandKinds))
            Me.SessionId = sessionId
            Me.CommandKinds = New ReadOnlyCollection(Of DriverCommandKind)(New List(Of DriverCommandKind)(commandKinds))
        End Sub

        Public ReadOnly Property SessionId As CanonicalId
        Public ReadOnly Property CommandKinds As IReadOnlyList(Of DriverCommandKind)
    End Class

    Public NotInheritable Class DriverStatusSnapshot
        Public Sub New(sessionId As CanonicalId,
                       machineId As CanonicalId,
                       profileHash As String,
                       sequence As Long,
                       receivedAtUtc As DateTimeOffset,
                       connectionState As DriverConnectionState,
                       isFresh As Boolean,
                       isStationary As Boolean?)
            If sessionId Is Nothing Then Throw New ArgumentNullException(NameOf(sessionId))
            If machineId Is Nothing Then Throw New ArgumentNullException(NameOf(machineId))
            If String.IsNullOrWhiteSpace(profileHash) Then Throw New ArgumentException("Profile hash is required.", NameOf(profileHash))
            If sequence < 0 Then Throw New ArgumentOutOfRangeException(NameOf(sequence))
            If receivedAtUtc.Offset <> TimeSpan.Zero Then Throw New ArgumentException("Status time must be UTC.", NameOf(receivedAtUtc))
            If Not [Enum].IsDefined(GetType(DriverConnectionState), connectionState) Then Throw New ArgumentOutOfRangeException(NameOf(connectionState))
            Me.SessionId = sessionId
            Me.MachineId = machineId
            Me.ProfileHash = profileHash
            Me.Sequence = sequence
            Me.ReceivedAtUtc = receivedAtUtc
            Me.ConnectionState = connectionState
            Me.IsFresh = isFresh
            Me.IsStationary = isStationary
        End Sub

        Public ReadOnly Property SessionId As CanonicalId
        Public ReadOnly Property MachineId As CanonicalId
        Public ReadOnly Property ProfileHash As String
        Public ReadOnly Property Sequence As Long
        Public ReadOnly Property ReceivedAtUtc As DateTimeOffset
        Public ReadOnly Property ConnectionState As DriverConnectionState
        Public ReadOnly Property IsFresh As Boolean
        Public ReadOnly Property IsStationary As Boolean?
    End Class

    Public NotInheritable Class DriverCommand
        Public Sub New(requestId As CanonicalId,
                       correlationId As CanonicalId,
                       machineId As CanonicalId,
                       sessionId As CanonicalId,
                       kind As DriverCommandKind,
                       schemaVersion As Integer,
                       Optional quantity As EngineeringQuantity = Nothing)
            If requestId Is Nothing Then Throw New ArgumentNullException(NameOf(requestId))
            If correlationId Is Nothing Then Throw New ArgumentNullException(NameOf(correlationId))
            If machineId Is Nothing Then Throw New ArgumentNullException(NameOf(machineId))
            If sessionId Is Nothing Then Throw New ArgumentNullException(NameOf(sessionId))
            If Not [Enum].IsDefined(GetType(DriverCommandKind), kind) Then Throw New ArgumentOutOfRangeException(NameOf(kind))
            If schemaVersion <= 0 Then Throw New ArgumentOutOfRangeException(NameOf(schemaVersion))
            Me.RequestId = requestId
            Me.CorrelationId = correlationId
            Me.MachineId = machineId
            Me.SessionId = sessionId
            Me.Kind = kind
            Me.SchemaVersion = schemaVersion
            Me.Quantity = quantity
        End Sub

        Public ReadOnly Property RequestId As CanonicalId
        Public ReadOnly Property CorrelationId As CanonicalId
        Public ReadOnly Property MachineId As CanonicalId
        Public ReadOnly Property SessionId As CanonicalId
        Public ReadOnly Property Kind As DriverCommandKind
        Public ReadOnly Property SchemaVersion As Integer
        Public ReadOnly Property Quantity As EngineeringQuantity
    End Class

    Public NotInheritable Class DriverCommandReceipt
        Public Sub New(requestId As CanonicalId, status As DriverCommandStatus, reasonCode As String, observedStatusSequence As Long)
            If requestId Is Nothing Then Throw New ArgumentNullException(NameOf(requestId))
            If Not [Enum].IsDefined(GetType(DriverCommandStatus), status) Then Throw New ArgumentOutOfRangeException(NameOf(status))
            If String.IsNullOrWhiteSpace(reasonCode) Then Throw New ArgumentException("Reason code is required.", NameOf(reasonCode))
            If observedStatusSequence < 0 Then Throw New ArgumentOutOfRangeException(NameOf(observedStatusSequence))
            Me.RequestId = requestId
            Me.Status = status
            Me.ReasonCode = reasonCode
            Me.ObservedStatusSequence = observedStatusSequence
        End Sub

        Public ReadOnly Property RequestId As CanonicalId
        Public ReadOnly Property Status As DriverCommandStatus
        Public ReadOnly Property ReasonCode As String
        Public ReadOnly Property ObservedStatusSequence As Long
    End Class

    Public NotInheritable Class RawMeasurementValue
        Public Sub New(pointIdentity As String, value As Double, unitCode As UnitCode, quality As MeasurementQuality)
            If String.IsNullOrWhiteSpace(pointIdentity) Then Throw New ArgumentException("Point identity is required.", NameOf(pointIdentity))
            If Double.IsNaN(value) OrElse Double.IsInfinity(value) Then Throw New ArgumentOutOfRangeException(NameOf(value))
            Me.PointIdentity = pointIdentity
            Me.Value = value
            Me.UnitCode = unitCode
            Me.Quality = quality
        End Sub

        Public ReadOnly Property PointIdentity As String
        Public ReadOnly Property Value As Double
        Public ReadOnly Property UnitCode As UnitCode
        Public ReadOnly Property Quality As MeasurementQuality
    End Class

    Public Interface IRawMeasurementFrameSink
        Function TryAccept(sequence As Long, values As IReadOnlyList(Of RawMeasurementValue)) As Boolean
    End Interface

    Public Interface IMachineDriver
        Function ConnectAsync(request As DriverConnectRequest, cancellationToken As CancellationToken) As Task(Of DriverConnectReceipt)
        Function DisconnectAsync(cancellationToken As CancellationToken) As Task
        Function GetCapabilitiesAsync(cancellationToken As CancellationToken) As Task(Of DriverCapabilities)
        Function ReadStatusAsync(cancellationToken As CancellationToken) As Task(Of DriverStatusSnapshot)
        Function ExecuteAsync(command As DriverCommand, cancellationToken As CancellationToken) As Task(Of DriverCommandReceipt)
        Sub AttachMeasurementSink(sink As IRawMeasurementFrameSink)
    End Interface
End Namespace

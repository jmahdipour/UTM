Namespace Common
    Public NotInheritable Class ReasonCodes
        Public Const Accepted As String = "SYSTEM.ACCEPTED"
        Public Const UnexpectedFailure As String = "SYSTEM.UNEXPECTED_FAILURE"
        Public Const SessionRequired As String = "AUTH.SESSION_REQUIRED"
        Public Const SessionExpired As String = "AUTH.SESSION_EXPIRED"
        Public Const PermissionDenied As String = "AUTH.PERMISSION_DENIED"
        Public Const SeparationOfDuties As String = "AUTH.SEPARATION_OF_DUTIES"
        Public Const RequiredValueMissing As String = "VALIDATION.REQUIRED_VALUE_MISSING"
        Public Const InvalidValue As String = "VALIDATION.INVALID_VALUE"
        Public Const NonfiniteNumber As String = "VALIDATION.NONFINITE_NUMBER"
        Public Const QuantityKindMismatch As String = "VALIDATION.QUANTITY_KIND_MISMATCH"
        Public Const UnitRequired As String = "VALIDATION.UNIT_REQUIRED"
        Public Const UnsupportedSchemaVersion As String = "VALIDATION.UNSUPPORTED_SCHEMA_VERSION"
        Public Const RevisionConflict As String = "CONCURRENCY.REVISION_CONFLICT"
        Public Const RequestIdPayloadMismatch As String = "CONCURRENCY.REQUEST_ID_PAYLOAD_MISMATCH"
        Public Const MachineStateInvalid As String = "STATE.MACHINE_STATE_INVALID"
        Public Const RunStateInvalid As String = "STATE.RUN_STATE_INVALID"
        Public Const SnapshotRequired As String = "STATE.SNAPSHOT_REQUIRED"
        Public Const ReconciliationRequired As String = "STATE.RECONCILIATION_REQUIRED"
        Public Const InterlockNotReady As String = "SAFETY.INTERLOCK_NOT_READY"
        Public Const InterlockStatusStale As String = "SAFETY.INTERLOCK_STATUS_STALE"
        Public Const InterlockStatusUnknown As String = "SAFETY.INTERLOCK_STATUS_UNKNOWN"
        Public Const DeviceDisconnected As String = "DEVICE.DISCONNECTED"
        Public Const DeviceCapabilityUnsupported As String = "DEVICE.CAPABILITY_UNSUPPORTED"
        Public Const DeviceAcknowledgementTimeout As String = "DEVICE.ACKNOWLEDGEMENT_TIMEOUT"
        Public Const PersistenceTransactionFailed As String = "PERSISTENCE.TRANSACTION_FAILED"
        Public Const ReportInputRevisionRequired As String = "REPORT.INPUT_REVISION_REQUIRED"

        Private Sub New()
        End Sub
    End Class
End Namespace

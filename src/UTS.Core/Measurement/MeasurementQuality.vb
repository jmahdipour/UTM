Imports System

Namespace Measurement
    <Flags>
    Public Enum MeasurementQuality
        None = 0
        Valid = 1
        Missing = 2
        Stale = 4
        GapBefore = 8
        Saturated = 16
        OverRange = 32
        UnderRange = 64
        CalibrationInvalid = 128
        SensorMismatch = 256
        CommunicationFault = 512
        OperatorSubstituted = 1024
    End Enum
End Namespace

Imports System
Imports System.Collections.Generic

Namespace Units
    Public NotInheritable Class UnitCatalog
        Public Const ConversionRevision As String = "units.v1"
        Public Const KilogramForceToNewton As Double = 9.80665R

        Private Shared ReadOnly Definitions As IReadOnlyDictionary(Of UnitCode, UnitDefinition) =
            New Dictionary(Of UnitCode, UnitDefinition) From {
                {UnitCode.Newton, New UnitDefinition(QuantityKind.Force, 1.0R, "N")},
                {UnitCode.Kilonewton, New UnitDefinition(QuantityKind.Force, 1000.0R, "kN")},
                {UnitCode.KilogramForce, New UnitDefinition(QuantityKind.Force, KilogramForceToNewton, "kgf")},
                {UnitCode.Millimetre, New UnitDefinition(QuantityKind.Length, 1.0R, "mm")},
                {UnitCode.Second, New UnitDefinition(QuantityKind.Time, 1.0R, "s")},
                {UnitCode.Megapascal, New UnitDefinition(QuantityKind.Stress, 1.0R, "MPa")},
                {UnitCode.Ratio, New UnitDefinition(QuantityKind.Strain, 1.0R, "1")},
                {UnitCode.Percent, New UnitDefinition(QuantityKind.Strain, 0.01R, "%")}
            }

        Private Sub New()
        End Sub

        Public Shared Sub EnsureCompatible(quantityKind As QuantityKind, unitCode As UnitCode)
            Dim definition As UnitDefinition = GetDefinition(unitCode)
            If definition.QuantityKind <> quantityKind Then
                Throw New ArgumentException("The unit is incompatible with the declared quantity kind.", NameOf(unitCode))
            End If
        End Sub

        Public Shared Function Convert(source As EngineeringQuantity, targetUnit As UnitCode) As EngineeringQuantity
            If source Is Nothing Then
                Throw New ArgumentNullException(NameOf(source))
            End If

            Dim sourceDefinition As UnitDefinition = GetDefinition(source.UnitCode)
            Dim targetDefinition As UnitDefinition = GetDefinition(targetUnit)
            If sourceDefinition.QuantityKind <> targetDefinition.QuantityKind Then
                Throw New ArgumentException("Source and target units describe different quantity kinds.", NameOf(targetUnit))
            End If

            Dim canonicalValue As Double = source.Value * sourceDefinition.ScaleToCanonical
            Dim convertedValue As Double = canonicalValue / targetDefinition.ScaleToCanonical
            Return New EngineeringQuantity(convertedValue, source.QuantityKind, targetUnit)
        End Function

        Public Shared Function GetSymbol(unitCode As UnitCode) As String
            Return GetDefinition(unitCode).Symbol
        End Function

        Private Shared Function GetDefinition(unitCode As UnitCode) As UnitDefinition
            Dim definition As UnitDefinition = Nothing
            If Not Definitions.TryGetValue(unitCode, definition) Then
                Throw New ArgumentOutOfRangeException(NameOf(unitCode), "Unknown unit code.")
            End If

            Return definition
        End Function

        Private NotInheritable Class UnitDefinition
            Public Sub New(quantityKind As QuantityKind, scaleToCanonical As Double, symbol As String)
                Me.QuantityKind = quantityKind
                Me.ScaleToCanonical = scaleToCanonical
                Me.Symbol = symbol
            End Sub

            Public ReadOnly Property QuantityKind As QuantityKind
            Public ReadOnly Property ScaleToCanonical As Double
            Public ReadOnly Property Symbol As String
        End Class
    End Class
End Namespace

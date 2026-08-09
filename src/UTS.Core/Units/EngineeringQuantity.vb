Imports System

Namespace Units
    Public NotInheritable Class EngineeringQuantity
        Public Sub New(value As Double, quantityKind As QuantityKind, unitCode As UnitCode)
            If Double.IsNaN(value) OrElse Double.IsInfinity(value) Then
                Throw New ArgumentOutOfRangeException(NameOf(value), "Engineering values must be finite.")
            End If

            UnitCatalog.EnsureCompatible(quantityKind, unitCode)
            Me.Value = value
            Me.QuantityKind = quantityKind
            Me.UnitCode = unitCode
        End Sub

        Public ReadOnly Property Value As Double
        Public ReadOnly Property QuantityKind As QuantityKind
        Public ReadOnly Property UnitCode As UnitCode

        Public Function ConvertTo(targetUnit As UnitCode) As EngineeringQuantity
            Return UnitCatalog.Convert(Me, targetUnit)
        End Function
    End Class
End Namespace

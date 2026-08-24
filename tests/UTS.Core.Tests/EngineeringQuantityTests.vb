Imports System
Imports NUnit.Framework
Imports UTS.Core.Units

Namespace Units
    <TestFixture>
    Public NotInheritable Class EngineeringQuantityTests
        <Test>
        Public Sub OneHundredKilogramForceConvertsToExactConventionalNewtonValue()
            Dim source As New EngineeringQuantity(100.0R, QuantityKind.Force, UnitCode.KilogramForce)
            Dim converted As EngineeringQuantity = source.ConvertTo(UnitCode.Newton)

            Assert.That(converted.Value, [Is].EqualTo(980.665R).Within(0.000000000001R))
            Assert.That(converted.UnitCode, [Is].EqualTo(UnitCode.Newton))
        End Sub

        <TestCase(Double.NaN)>
        <TestCase(Double.PositiveInfinity)>
        <TestCase(Double.NegativeInfinity)>
        Public Sub NonfiniteValuesAreRejected(value As Double)
            Assert.Throws(Of ArgumentOutOfRangeException)(
                Sub()
                    Dim discarded = New EngineeringQuantity(value, QuantityKind.Force, UnitCode.Newton)
                End Sub)
        End Sub

        <Test>
        Public Sub IncompatibleKindAndUnitAreRejected()
            Assert.Throws(Of ArgumentException)(
                Sub()
                    Dim discarded = New EngineeringQuantity(10.0R, QuantityKind.Length, UnitCode.Newton)
                End Sub)
        End Sub
    End Class
End Namespace

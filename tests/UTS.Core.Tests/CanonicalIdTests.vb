Imports System
Imports NUnit.Framework
Imports UTS.Core.Common

Namespace Common
    <TestFixture>
    Public NotInheritable Class CanonicalIdTests
        <Test>
        Public Sub FromGuidProducesLowercaseCanonicalText()
            Dim identifier As CanonicalId = CanonicalId.FromGuid(Guid.Parse("AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE"))
            Assert.That(identifier.Value, [Is].EqualTo("aaaaaaaa-bbbb-4ccc-8ddd-eeeeeeeeeeee"))
        End Sub

        <Test>
        Public Sub ParseRejectsUppercaseText()
            Assert.That(
                Sub() CanonicalId.Parse("AAAAAAAA-BBBB-4CCC-8DDD-EEEEEEEEEEEE"),
                Throws.TypeOf(Of FormatException)())
        End Sub
    End Class
End Namespace

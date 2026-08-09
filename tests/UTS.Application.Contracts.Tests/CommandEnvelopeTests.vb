Imports System
Imports System.Linq
Imports NUnit.Framework
Imports UTS.Application.Contracts.Commands
Imports UTS.Core.Common

Namespace Commands
    <TestFixture>
    Public NotInheritable Class CommandEnvelopeTests
        Private NotInheritable Class SamplePayload
        End Class

        <Test>
        Public Sub EnvelopeExposesSessionIdentityButNoTrustedRoleOrActorName()
            Dim propertyNames As String() = GetType(CommandEnvelope(Of SamplePayload)).GetProperties().Select(Function(item) item.Name).ToArray()

            Assert.That(propertyNames, Does.Contain("ActorSessionId"))
            Assert.That(propertyNames, Does.Not.Contain("Role"))
            Assert.That(propertyNames, Does.Not.Contain("ActorName"))
            Assert.That(propertyNames, Does.Not.Contain("Permission"))
        End Sub

        <Test>
        Public Sub NonUtcRequestedTimeIsRejected()
            Dim identifier As CanonicalId = CanonicalId.FromGuid(Guid.NewGuid())
            Dim localOffset As New DateTimeOffset(2026, 8, 9, 12, 0, 0, TimeSpan.FromHours(2))

            Assert.That(
                Sub() New CommandEnvelope(Of SamplePayload)(identifier, "SYS.TEST", 1, identifier, localOffset, identifier, New SamplePayload()),
                Throws.TypeOf(Of ArgumentException)())
        End Sub
    End Class
End Namespace

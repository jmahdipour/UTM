Imports System

Namespace Common
    Public NotInheritable Class CanonicalId
        Implements IEquatable(Of CanonicalId)

        Private ReadOnly _value As String

        Private Sub New(value As String)
            _value = value
        End Sub

        Public ReadOnly Property Value As String
            Get
                Return _value
            End Get
        End Property

        Public Shared Function Parse(value As String) As CanonicalId
            If String.IsNullOrWhiteSpace(value) Then
                Throw New ArgumentException("A canonical identifier is required.", NameOf(value))
            End If

            Dim parsed As Guid
            If Not Guid.TryParseExact(value, "D", parsed) Then
                Throw New FormatException("The identifier must use canonical GUID D format.")
            End If

            Dim canonical As String = parsed.ToString("D").ToLowerInvariant()
            If Not StringComparer.Ordinal.Equals(value, canonical) Then
                Throw New FormatException("The identifier must be lowercase canonical GUID text.")
            End If

            Return New CanonicalId(canonical)
        End Function

        Public Shared Function FromGuid(value As Guid) As CanonicalId
            If value = Guid.Empty Then
                Throw New ArgumentException("An empty GUID is not a valid persistent identity.", NameOf(value))
            End If

            Return New CanonicalId(value.ToString("D").ToLowerInvariant())
        End Function

        Public Overloads Function Equals(other As CanonicalId) As Boolean Implements IEquatable(Of CanonicalId).Equals
            Return other IsNot Nothing AndAlso StringComparer.Ordinal.Equals(_value, other._value)
        End Function

        Public Overrides Function Equals(obj As Object) As Boolean
            Return Equals(TryCast(obj, CanonicalId))
        End Function

        Public Overrides Function GetHashCode() As Integer
            Return StringComparer.Ordinal.GetHashCode(_value)
        End Function

        Public Overrides Function ToString() As String
            Return _value
        End Function
    End Class
End Namespace

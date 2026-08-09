Imports System.Threading
Imports System.Threading.Tasks
Imports UTS.Application.Contracts.Queries
Imports UTS.Core.Common

Namespace Ports
    Public Interface IQueryHandler(Of TQuery, TResult)
        Function ExecuteAsync(query As TQuery,
                              actorSessionId As CanonicalId,
                              cancellationToken As CancellationToken) As Task(Of QueryResult(Of TResult))
    End Interface
End Namespace

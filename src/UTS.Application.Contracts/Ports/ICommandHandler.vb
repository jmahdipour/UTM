Imports System.Threading
Imports System.Threading.Tasks
Imports UTS.Application.Contracts.Commands

Namespace Ports
    Public Interface ICommandHandler(Of TCommand)
        Function HandleAsync(envelope As CommandEnvelope(Of TCommand),
                             cancellationToken As CancellationToken) As Task(Of CommandReceipt)
    End Interface
End Namespace

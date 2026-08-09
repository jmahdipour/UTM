Imports System
Imports System.Data.SQLite
Imports System.IO
Imports NUnit.Framework
Imports UTS.Infrastructure.SQLite.Runtime

Namespace Runtime
    <TestFixture>
    Public NotInheritable Class SQLiteRuntimeProbeTests
        <Test>
        Public Sub ProviderLoadsAndExecutesWalTransactionInX86Process()
            Assert.That(IntPtr.Size, [Is].EqualTo(4), "The Frozen runtime target is x86.")

            Dim databasePath As String = Path.Combine(Path.GetTempPath(), "uts-sqlite-smoke-" & Guid.NewGuid().ToString("N") & ".db")
            Try
                Dim connectionString As String = "Data Source=" & databasePath & ";Version=3;Foreign Keys=True;Synchronous=Full;"
                Dim probe As New SQLiteRuntimeProbe()
                Dim engineVersion As String = probe.Execute(connectionString)
                Assert.That(engineVersion, [Is].Not.Empty)

                Using connection As New SQLiteConnection(connectionString)
                    connection.Open()
                    Using command As SQLiteCommand = connection.CreateCommand()
                        command.CommandText = "pragma journal_mode=wal;"
                        Assert.That(Convert.ToString(command.ExecuteScalar()), [Is].EqualTo("wal").IgnoreCase)
                        command.CommandText = "create table smoke_test (id integer primary key, value text not null); insert into smoke_test(value) values ('ok'); select count(*) from smoke_test;"
                        Assert.That(Convert.ToInt32(command.ExecuteScalar()), [Is].EqualTo(1))
                    End Using
                End Using
            Finally
                DeleteIfPresent(databasePath)
                DeleteIfPresent(databasePath & "-wal")
                DeleteIfPresent(databasePath & "-shm")
            End Try
        End Sub

        Private Shared Sub DeleteIfPresent(path As String)
            If File.Exists(path) Then File.Delete(path)
        End Sub
    End Class
End Namespace

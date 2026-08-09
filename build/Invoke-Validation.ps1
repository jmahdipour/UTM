[CmdletBinding()]
param(
    [ValidateSet("Debug", "Release")]
    [string]$Configuration = "Release"
)

$ErrorActionPreference = "Stop"
$repositoryRoot = Split-Path -Parent $PSScriptRoot

python (Join-Path $repositoryRoot "tools\validate_implementation_baseline.py")
if ($LASTEXITCODE -ne 0) { throw "Static baseline validation failed." }

msbuild (Join-Path $repositoryRoot "UTS.sln") /restore /m /p:Configuration=$Configuration /p:Platform=x86
if ($LASTEXITCODE -ne 0) { throw "Solution build failed." }

$vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
$visualStudio = & $vswhere -latest -products * -requires Microsoft.VisualStudio.Workload.ManagedDesktop -property installationPath
$vstest = Join-Path $visualStudio "Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe"
$assemblies = Get-ChildItem (Join-Path $repositoryRoot "tests") -Recurse -Filter "UTS.*.Tests.dll" |
    Where-Object { $_.FullName -match "\\bin\\x86\\$Configuration\\net48\\" } |
    Select-Object -ExpandProperty FullName

if (-not $assemblies) { throw "No test assemblies were found." }
& $vstest @assemblies /Platform:x86 /Logger:trx
if ($LASTEXITCODE -ne 0) { throw "Executable tests failed." }

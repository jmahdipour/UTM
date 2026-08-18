# Build and Test

## Required workstation

- Windows with Visual Studio Build Tools/Visual Studio managed-desktop workload;
- .NET Framework 4.8 runtime and targeting support;
- Python 3 for repository validators;
- x86 test execution enabled.

## Controlled commands

```powershell
python tools/validate_implementation_baseline.py
./build/Invoke-Validation.ps1 -Configuration Debug
./build/Invoke-Validation.ps1 -Configuration Release
```

The PowerShell workflow restores centrally pinned packages, builds the entire Solution as x86 and runs all NUnit assemblies with VSTest x86. `UTS.Infrastructure.SQLite.Tests` is the required native-provider/WAL smoke gate.

## Evidence boundary

A static PASS proves document/project/reference consistency only. A Windows CI PASS is required for executable/build/provider claims. Hardware commissioning remains outside this workflow and blocked under EDR-0009.

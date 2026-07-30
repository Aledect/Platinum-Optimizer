# Platinum+ Optimizer - Normal Admin Launcher
Set-Location $PSScriptRoot

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$PSScriptRoot\run.ps1`""
    $psi.Verb = "runas"
    $psi.WorkingDirectory = $PSScriptRoot
    [System.Diagnostics.Process]::Start($psi) | Out-Null
} else {
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$PSScriptRoot\run.ps1"
}

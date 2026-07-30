
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$Name = "Registry_Backup_$(Get-Date -f 'yyyyMMdd_HHmmss')",
    
    [Parameter(Mandatory=$false)]
    [string]$OutDir,

    [Parameter(Mandatory=$false)]
    [string]$RootKey = "HKLM"
)

if ([string]::IsNullOrWhiteSpace($OutDir)) {
    $OutDir = Join-Path $PSScriptRoot "registry"
}

try {
    if (-not (Test-Path $OutDir)) { 
        New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
    }
    
    $outPath = Join-Path -Path $OutDir -ChildPath "$Name.reg"
    
    $process = Start-Process -FilePath "reg.exe" -ArgumentList "export $RootKey `"$outPath`" /y" -Wait -WindowStyle Hidden -PassThru
    
    if ($process.ExitCode -eq 0 -and (Test-Path $outPath)) {
        Write-Host "Registry backup created successfully: $outPath" -ForegroundColor Green
    } else {
        Write-Host "Failed to create registry backup." -ForegroundColor Red
    }
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}
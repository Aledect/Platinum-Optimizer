
[CmdletBinding()]
param(
    [Parameter(Mandatory=$false, HelpMessage="Name of the restore point")]
    [string]$Name = "RestorePoint_$(Get-Date -f 'yyyyMMdd_HHmmss')",
    
    [Parameter(Mandatory=$false, HelpMessage="Output directory for tracking files")]
    [string]$OutDir
)

if ([string]::IsNullOrWhiteSpace($OutDir)) {
    $OutDir = Join-Path $PSScriptRoot "restore"
}


$services = @("vss", "swprv")
foreach ($srv in $services) {
    try {
        # Set to Manual to be able to start them, ignoring errors
        Set-Service -Name $srv -StartupType Manual -ErrorAction SilentlyContinue
        Start-Service -Name $srv -ErrorAction SilentlyContinue
    } catch {
        # Ignore error and continue as requested
    }
}

try {

    # Force removal of registry block (if present)
    $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore"
    if (Test-Path $regPath) {
        Set-ItemProperty -Path $regPath -Name "DisableSR" -Value 0 -ErrorAction SilentlyContinue
    }
    

    $sysDrive = $env:SystemDrive + "\"
    Enable-ComputerRestore -Drive $sysDrive -ErrorAction SilentlyContinue 

    Write-Host "Creating restore point '$Name'..." -ForegroundColor Cyan
    Checkpoint-Computer -Description $Name -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
    

    $rp = Get-ComputerRestorePoint -ErrorAction SilentlyContinue | Sort-Object SequenceNumber -Descending | Select-Object -First 1
    
    if ($rp) {
        $id = $rp.SequenceNumber
        
        # Create directory and save tracking info
        if (-not (Test-Path $OutDir)) { 
            New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
        }
        
        $outPath = Join-Path -Path $OutDir -ChildPath "$Name.txt"
        
        $info = [PSCustomObject]@{
            ID = $id
            Name = $Name
            CreationTime = $rp.CreationTime
            SystemDrive = $sysDrive
        }
        
        $info | ConvertTo-Json | Out-File -FilePath $outPath -Encoding utf8 -Force
        Write-Host "Success! Restore point created with ID: $id. Info saved to: $outPath" -ForegroundColor Green
    }
} catch {
    Write-Host "Error during creation: $_" -ForegroundColor Red
}
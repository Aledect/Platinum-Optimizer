
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, HelpMessage="Tracking file name (with .txt extension)")]
    [string]$FileName,
    
    [Parameter(Mandatory=$false, HelpMessage="Input directory where tracking files reside")]
    [string]$InDir
)

if ([string]::IsNullOrWhiteSpace($InDir)) {
    $InDir = Join-Path $PSScriptRoot "restore"
}

$services = @("vss", "swprv")
foreach ($srv in $services) {
    try {
        Set-Service -Name $srv -StartupType Manual -ErrorAction SilentlyContinue
        Start-Service -Name $srv -ErrorAction SilentlyContinue
    } catch {
        # Ignore if it fails
    }
}

$inPath = Join-Path -Path $InDir -ChildPath $FileName

if (Test-Path $inPath) {
    try {

        $content = Get-Content -Path $inPath -Raw
        $content = $content.Trim()
        $id = $null
        

        try {
            $jsonParsed = $content | ConvertFrom-Json -ErrorAction Stop
            if ($null -ne $jsonParsed.ID) {
                $id = [int]$jsonParsed.ID
                Write-Host "Identified restore point '$($jsonParsed.Name)' from $($jsonParsed.CreationTime)" -ForegroundColor Cyan
            }
        } catch {
            # Fallback: If not JSON, check if it's a numeric string (old script)
            if ($content -match '^\d+$') {
                $id = [int]$content
            }
        }


        if ($null -ne $id) {
            Write-Host "Starting system restore with ID: $id..." -ForegroundColor Yellow
            Restore-Computer -RestorePoint $id -Confirm:$false
            # Computer will restart automatically if restore starts successfully
        } else {
            Write-Host "Unable to extract valid ID from file: $inPath" -ForegroundColor Red
        }
    } catch {
        Write-Host "Error during restore phase: $_" -ForegroundColor Red
    }
} else {
    Write-Host "Tracking file not found in: $inPath" -ForegroundColor Red
}
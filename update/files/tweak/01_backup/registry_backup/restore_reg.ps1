
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$FileName,
    
    [Parameter(Mandatory=$false)]
    [string]$InDir
)

if ([string]::IsNullOrWhiteSpace($InDir)) {
    $InDir = Join-Path $PSScriptRoot "registry"
}

$inPath = Join-Path -Path $InDir -ChildPath $FileName

if (Test-Path $inPath) {
    try {
        $process = Start-Process -FilePath "reg.exe" -ArgumentList "import `"$inPath`"" -Wait -WindowStyle Hidden -PassThru
        
        if ($process.ExitCode -eq 0) {
            Write-Host "Registry restored successfully from: $inPath" -ForegroundColor Green
        } else {
            Write-Host "Failed to restore registry." -ForegroundColor Red
        }
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
} else {
    Write-Host "File not found: $inPath" -ForegroundColor Red
}
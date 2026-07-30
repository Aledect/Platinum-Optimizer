# Platinum+ Optimizer Installer Bootstrapper
# Entrypoint: irm https://platinum.optimizer.workers.dev/program | iex

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ErrorActionPreference = "Stop"

# Auto-maximize PowerShell terminal window and expand buffer
try {
    $win32 = Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow); [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();' -Name "Win32Max" -Namespace "Win32" -PassThru
    $hwnd = $win32::GetForegroundWindow()
    $win32::ShowWindow($hwnd, 3) | Out-Null # 3 = SW_MAXIMIZE
} catch {}

try {
    $rawUI = $host.UI.RawUI
    $buf = $rawUI.BufferSize
    if ($buf.Width -lt 160) { $buf.Width = 160 }
    if ($buf.Height -lt 500) { $buf.Height = 500 }
    $rawUI.BufferSize = $buf

    $win = $rawUI.WindowSize
    $maxW = $rawUI.MaxPhysicalWindowSize.Width
    $maxH = $rawUI.MaxPhysicalWindowSize.Height
    if ($maxW -ge 120) { $win.Width = [Math]::Min(150, $maxW) }
    if ($maxH -ge 45)  { $win.Height = [Math]::Min(45, $maxH) }
    $rawUI.WindowSize = $win
} catch {}

Clear-Host
try { $host.UI.RawUI.WindowTitle = "Platinum+ Optimizer Installer" } catch {}

Write-Host @"
                                                :..:                                                  
                                              :.....:                                               
                                             :........:                                             
                                            ...........-                                            
                                          =.............:                                           
                                         +.............:..                                          
                                        :.......*#*-..::::.                                         
                                       :.......*####+.::::::                                        
                                      :......:#######*::::::::                                      
                                     ....::.=##########::::::::                                     
                                    -====++*############+=------                                    
                                    **########################+=-                                   
                      -:::::::::::::----------===-------==+*#####=                                  
                       -.:::::::::::::::::::::................=####                                 
                         --:::::::::::::::::::..................=###                                
                          =+-+++++===----:::::----=======:.......=####                              
                           ++=++++++=============++++++++++=.....-#####                             
                            #############################++=:....-######                            
                          *###########-========*#########+==....:=#######                           
                         ############+:.......=*#########--:....-####:....-                         
                        *############-.......=+########*--:.....+###-..:.-##                        
                       **###########+:......-+##-:::::::..:::::=###*:.:::+###                       
                      **############-::.....+*#*::::::::::::::+####=.::.=#####                      
                     +*******######+:::::..=+##+:::::::::::=+######:.::-*######                     
                    +*******#######-:::::::+######################=::::-#######*+-                  
                   +*******#######+-:::::.=====-----*##*-.:::::::::::::::::::::::+                  
                 ==******+########=::::::........==###+-:::::::::::::::::-------+*                  
                +=++++**+########+:::::::......-=+###=-----:--==+=:::=++++++++++**+                 
               =+++++++=########*=:::::--::...==*###############*-:::+#######******+=               
              -=+++++=+#########+:---===::::.==#################=:::-*#######*+*+++++-              
             -=======+##########--=====-::::==++=+*############=:--:+##########=++++==-             
            -======-*##########+-======:::::::=+*#############*-:---*###########=======-            
           :------:*##########*==+++++-:::::-+*###############=----+#############--=----:           
         =:-------############+-+++++=:::::+*#####################################=------:-         
        -:::::::-############*=++++++-:::+*########################################=:-----:-        
       :.::::::-#############+=*++**=::-*###########################################=:-----::       
      :..::::::##############-*****:--*##############################################-------:-      
     :......::::############++***+--*###############################################=:--------:     
    :.......:::::----===++++-***--*######****+++++++========------------:::::::::-------------:     
    :........::::----===+++==*+=+######******+++++++========----------------------------------:     
     :.......:::::---===+++=*++#######*******+++++++=======---------------------------------::      
        :::::::-----===+ *==+##############**+*+++++=======================------=-=------=         
                         +=*##                                                                  
"@ -ForegroundColor Cyan

Write-Host "                ============================================================" -ForegroundColor DarkCyan
Write-Host "                               Platinum+ Optimizer Installer                " -ForegroundColor White
Write-Host "                ============================================================" -ForegroundColor DarkCyan
Write-Host ""

function Format-TechLog {
    param([string]$Component, [string]$Level, [string]$Message)
    $ts = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss.fff")
    return "[$ts] [$Component] [$Level] $Message"
}

# Inspect environment context
$scriptDir = $null
if ($MyInvocation.MyCommand.Path) {
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
}

$localSetupPath = $null
if ($scriptDir) {
    $possibleSetup = Join-Path $scriptDir "program\setup.ps1"
    if (Test-Path -LiteralPath $possibleSetup) {
        $localSetupPath = $possibleSetup
    }
}

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($localSetupPath) {
    # Local execution path - Execute in same shell
    $workDir = Join-Path $scriptDir "program"
    Write-Host (Format-TechLog "BOOTSTRAP" "INFO" "Local deployment target resolved: $localSetupPath") -ForegroundColor Cyan
    Write-Host (Format-TechLog "PRIVILEGE" "INFO" "Elevation Status: Admin=$isAdmin") -ForegroundColor Cyan
    
    Set-Location -Path $workDir
    . $localSetupPath
} else {
    # Remote web execution path - Execute in same shell
    Write-Host (Format-TechLog "BOOTSTRAP" "INFO" "Initializing remote bootstrapper pipeline in current shell...") -ForegroundColor Cyan
    Write-Host (Format-TechLog "PRIVILEGE" "INFO" "Elevation Status: Admin=$isAdmin") -ForegroundColor Cyan

    $githubRaw = "https://raw.githubusercontent.com/Aledect/Platinum-Optimizer/main/program"
    $tempDir = Join-Path $env:TEMP "PlatinumOptimizer_Installer"

    try {
        if (Test-Path -LiteralPath $tempDir) {
            Remove-Item -LiteralPath $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        }
        New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
        Write-Host (Format-TechLog "FS" "INFO" "Created working directory: $tempDir") -ForegroundColor Gray

        $installerFiles = @(
            "setup.ps1",
            "version.json",
            "installer/install.ps1",
            "installer/uninstall.ps1",
            "installer/uninstall.bat",
            "installer/XAML/installer.xaml",
            "installer/ico/logo.png",
            "installer/ico/platinum.ico",
            "installer/ico/platinum.png"
        )

        Write-Host (Format-TechLog "HTTP" "INFO" "Fetching $($installerFiles.Count) bootstrap assets from GitHub Raw...") -ForegroundColor Yellow

        foreach ($file in $installerFiles) {
            $destFile = Join-Path $tempDir ($file -replace '/', '\')
            $parent = Split-Path -Parent $destFile
            if (-not (Test-Path -LiteralPath $parent)) {
                New-Item -ItemType Directory -Path $parent -Force | Out-Null
            }
            $fileUrl = "$githubRaw/$file"
            Invoke-WebRequest -Uri $fileUrl -OutFile $destFile -UseBasicParsing -TimeoutSec 30
            Write-Host (Format-TechLog "HTTP" "DEBUG" "GET $file -> 200 OK") -ForegroundColor DarkGray
        }

        $setupScript = Join-Path $tempDir "setup.ps1"
        if (-not (Test-Path -LiteralPath $setupScript)) {
            throw "Target entrypoint script missing: $setupScript"
        }

        Write-Host (Format-TechLog "EXEC" "INFO" "Executing setup entrypoint directly in active shell session...") -ForegroundColor Green
        Set-Location -Path $tempDir
        
        # Dot-source and invoke in active session
        . $setupScript
    } catch {
        Write-Host (Format-TechLog "BOOTSTRAP" "ERROR" "Pipeline exception: $_") -ForegroundColor Red
    }
}

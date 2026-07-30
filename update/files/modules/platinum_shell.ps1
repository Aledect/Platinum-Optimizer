# Platinum+ Shell - Custom PowerShell Shell (Read-Only with Logging)
# This module creates a read-only PowerShell shell with Platinum+ branding and comprehensive logging

# Initialize logging system - use program directory /log folder
$script:LogFilePath = "$ModuleRoot\log"
if (-not (Test-Path $script:LogFilePath)) {
    New-Item -ItemType Directory -Path $script:LogFilePath -Force | Out-Null
}
$script:CurrentLogFile = Join-Path $script:LogFilePath "PlatinumShell_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-PlatinumLog {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] [$Level] $Message"
    
    # Write to log file
    Add-Content -Path $script:CurrentLogFile -Value $logEntry
    
    # Also write to shell output if available
    if ($global:PlatinumShellOutput) {
        $color = switch ($Level) {
            "ERROR" { [System.Drawing.Color]::FromArgb(255, 100, 100) }
            "WARN"  { [System.Drawing.Color]::FromArgb(255, 200, 100) }
            "SUCCESS" { [System.Drawing.Color]::FromArgb(100, 255, 100) }
            "BAT"   { [System.Drawing.Color]::FromArgb(255, 180, 50) }
            default { [System.Drawing.Color]::FromArgb(200, 200, 200) }
        }
        
        $originalSelection = $global:PlatinumShellOutput.SelectionStart
        $originalLength = $global:PlatinumShellOutput.SelectionLength
        
        $global:PlatinumShellOutput.AppendText($logEntry + "`r`n")
        $global:PlatinumShellOutput.Select($originalSelection, 0)
        $global:PlatinumShellOutput.SelectionStart = $global:PlatinumShellOutput.Text.Length
        $global:PlatinumShellOutput.ScrollToCaret()
    }
}

function Log-BatExecution {
    param(
        [string]$BatFilePath,
        [string]$Status = "STARTED"
    )
    
    $batName = Split-Path $BatFilePath -Leaf
    Write-PlatinumLog "BAT EXECUTION: $batName - $Status" -Level "BAT"
}

function Log-ProgramAction {
    param(
        [string]$Action,
        [string]$Details = ""
    )
    
    if ($Details) {
        Write-PlatinumLog "ACTION: $Action - $Details" -Level "INFO"
    } else {
        Write-PlatinumLog "ACTION: $Action" -Level "INFO"
    }
}

function Invoke-LoggedBat {
    param(
        [string]$BatPath,
        [string]$Arguments = ""
    )

    if (-not (Test-Path $BatPath)) {
        Write-PlatinumLog "FILE NOT FOUND: $BatPath" -Level "ERROR"
        return $false
    }

    $extension = [System.IO.Path]::GetExtension($BatPath).ToLower()
    $fileName = Split-Path $BatPath -Leaf

    Write-PlatinumLog "EXECUTING: $fileName" -Level "INFO"

    try {
        if ($extension -eq ".ps1") {
            # Execute PowerShell script with output redirected to shell
            $processInfo = New-Object System.Diagnostics.ProcessStartInfo
            $processInfo.FileName = "powershell.exe"
            $processInfo.Arguments = "-ExecutionPolicy Bypass -File `"$BatPath`" $Arguments"
            $processInfo.UseShellExecute = $false
            $processInfo.RedirectStandardOutput = $true
            $processInfo.RedirectStandardError = $true
            $processInfo.CreateNoWindow = $true

            $process = New-Object System.Diagnostics.Process
            $process.StartInfo = $processInfo
            $process.Start() | Out-Null

            # Read output line by line in real-time
            $outputBuilder = New-Object System.Text.StringBuilder
            while (!$process.StandardOutput.EndOfStream) {
                $line = $process.StandardOutput.ReadLine()
                if ($line) {
                    Write-PlatinumLog $line -Level "INFO"
                }
            }

            # Read error output
            while (!$process.StandardError.EndOfStream) {
                $line = $process.StandardError.ReadLine()
                if ($line) {
                    Write-PlatinumLog $line -Level "ERROR"
                }
            }

            $process.WaitForExit()

            if ($process.ExitCode -eq 0) {
                Write-PlatinumLog "COMPLETED: $fileName" -Level "INFO"
                return $true
            } else {
                Write-PlatinumLog "FAILED: $fileName (Exit Code: $($process.ExitCode))" -Level "ERROR"
                return $false
            }
        }
        elseif ($extension -eq ".bat" -or $extension -eq ".cmd") {
            # Execute batch file with output redirected to shell
            $processInfo = New-Object System.Diagnostics.ProcessStartInfo
            $processInfo.FileName = "cmd.exe"
            $processInfo.Arguments = "/c `"$BatPath`" $Arguments"
            $processInfo.WorkingDirectory = Split-Path $BatPath -Parent
            $processInfo.UseShellExecute = $false
            $processInfo.RedirectStandardOutput = $true
            $processInfo.RedirectStandardError = $true
            $processInfo.CreateNoWindow = $true

            $process = New-Object System.Diagnostics.Process
            $process.StartInfo = $processInfo
            $process.Start() | Out-Null

            # Read output line by line in real-time
            while (!$process.StandardOutput.EndOfStream) {
                $line = $process.StandardOutput.ReadLine()
                if ($line) {
                    Write-PlatinumLog $line -Level "INFO"
                }
            }

            # Read error output
            while (!$process.StandardError.EndOfStream) {
                $line = $process.StandardError.ReadLine()
                if ($line) {
                    Write-PlatinumLog $line -Level "ERROR"
                }
            }

            $process.WaitForExit()

            if ($process.ExitCode -eq 0) {
                Write-PlatinumLog "COMPLETED: $fileName" -Level "INFO"
                return $true
            } else {
                Write-PlatinumLog "FAILED: $fileName (Exit Code: $($process.ExitCode))" -Level "ERROR"
                return $false
            }
        }
        else {
            Write-PlatinumLog "UNSUPPORTED FILE TYPE: $extension" -Level "ERROR"
            return $false
        }
    } catch {
        Write-PlatinumLog "EXCEPTION: $fileName - $($_.Exception.Message)" -Level "ERROR"
        return $false
    }
}

function Initialize-PlatinumShell {
    param(
        [string]$LogoPath
    )

    # Create a minimal PowerShell host window
    $shell = New-Object System.Windows.Forms.Form
    $shell.Text = "Platinum+ Shell"
    $shell.Size = New-Object System.Drawing.Size(800, 550)
    $shell.StartPosition = "Manual"
    $shell.BackColor = [System.Drawing.Color]::Black
    $shell.ForeColor = [System.Drawing.Color]::White
    $shell.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $shell.TopMost = $false
    $shell.ShowInTaskbar = $true
    $shell.FormBorderStyle = "Sizable"
    $shell.MaximizeBox = $true

    # Position shell on opposite side of screen (left side)
    $screen = [System.Windows.Forms.Screen]::PrimaryScreen
    $shell.Location = New-Object System.Drawing.Point(50, 100)

    # Header panel with logo
    $headerPanel = New-Object System.Windows.Forms.Panel
    $headerPanel.Height = 60
    $headerPanel.Dock = "Top"
    $headerPanel.BackColor = [System.Drawing.Color]::FromArgb(20, 20, 25)
    $shell.Controls.Add($headerPanel)

    # Resolve official Platinum logo path (always force official Platinum logo)
    $officialPlatinumLogo = Join-Path $ModuleRoot "ico\logo.png"
    if (Test-Path $officialPlatinumLogo) {
        $LogoPath = $officialPlatinumLogo
    } elseif ([string]::IsNullOrWhiteSpace($LogoPath) -or -not (Test-Path $LogoPath)) {
        $LogoPath = Join-Path $ModuleRoot "ico\logo.png"
    }

    # Set Window Icon
    try {
        $iconPath = Join-Path $ModuleRoot "ico\platinum.ico"
        if (Test-Path $iconPath) {
            $shell.Icon = New-Object System.Drawing.Icon($iconPath)
        }
    } catch {}

    # Load logo
    try {
        if (Test-Path $LogoPath) {
            $logoImage = [System.Drawing.Image]::FromFile($LogoPath)
            $logoPictureBox = New-Object System.Windows.Forms.PictureBox
            $logoPictureBox.Image = $logoImage
            $logoPictureBox.Size = New-Object System.Drawing.Size(40, 40)
            $logoPictureBox.Location = New-Object System.Drawing.Point(15, 10)
            $logoPictureBox.SizeMode = "Zoom"
            $headerPanel.Controls.Add($logoPictureBox)
        }
    } catch {
        Write-Warning "Failed to load logo image"
    }

    # Title label
    $titleLabel = New-Object System.Windows.Forms.Label
    $titleLabel.Text = "Platinum+ Shell"
    $titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
    $titleLabel.ForeColor = [System.Drawing.Color]::White
    $titleLabel.Location = New-Object System.Drawing.Point(65, 15)
    $titleLabel.AutoSize = $true
    $headerPanel.Controls.Add($titleLabel)

    # Output text box (read-only - minimal design)
    $outputTextBox = New-Object System.Windows.Forms.RichTextBox
    $outputTextBox.Dock = "Fill"
    $outputTextBox.BackColor = [System.Drawing.Color]::Black
    $outputTextBox.ForeColor = [System.Drawing.Color]::White
    $outputTextBox.Font = New-Object System.Drawing.Font("Consolas", 10)
    $outputTextBox.ReadOnly = $true
    $outputTextBox.BorderStyle = "None"
    $outputTextBox.Multiline = $true
    $outputTextBox.ScrollBars = "Vertical"
    $outputTextBox.Text = "Platinum+ Shell - Activity Monitor`r`n"
    $outputTextBox.Text += "=========================================`r`n"
    $outputTextBox.Text += "Log folder: " + $script:LogFilePath + "`r`n"
    $outputTextBox.Text += "=========================================`r`n`r`n"
    $shell.Controls.Add($outputTextBox)

    # Button panel at bottom
    $buttonPanel = New-Object System.Windows.Forms.Panel
    $buttonPanel.Height = 60
    $buttonPanel.Dock = "Bottom"
    $buttonPanel.BackColor = [System.Drawing.Color]::FromArgb(20, 20, 25)
    $buttonPanel.Padding = New-Object System.Windows.Forms.Padding(10, 10, 10, 10)
    $shell.Controls.Add($buttonPanel)

    # Common button style
    $buttonWidth = 140
    $buttonHeight = 40

    # Clear logs button
    $clearButton = New-Object System.Windows.Forms.Button
    $clearButton.Text = "Clear All Logs"
    $clearButton.Location = New-Object System.Drawing.Point(10, 10)
    $clearButton.Size = New-Object System.Drawing.Size($buttonWidth, $buttonHeight)
    $clearButton.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 70)
    $clearButton.ForeColor = [System.Drawing.Color]::White
    $clearButton.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $clearButton.FlatStyle = "Flat"
    $clearButton.FlatAppearance.BorderSize = 1
    $clearButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(100, 100, 110)
    $clearButton.Cursor = [System.Windows.Forms.Cursors]::Hand
    $clearButton.Add_MouseEnter({ $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(0, 180, 219) })
    $clearButton.Add_MouseLeave({ $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(100, 100, 110) })
    $clearButton.Add_Click({
        try {
            Get-ChildItem -Path $script:LogFilePath -Filter "*.log" | Remove-Item -Force
            Write-PlatinumLog "All logs cleared" -Level "INFO"
            Show-CustomPopup "All log files have been deleted." "Logs Cleared" "Success"
        } catch {
            Write-PlatinumLog "Failed to clear logs: $($_.Exception.Message)" -Level "ERROR"
        }
    })
    $buttonPanel.Controls.Add($clearButton)

    # Refresh logs button
    $refreshButton = New-Object System.Windows.Forms.Button
    $refreshButton.Text = "Refresh Logs"
    $refreshButton.Location = New-Object System.Drawing.Point(160, 10)
    $refreshButton.Size = New-Object System.Drawing.Size($buttonWidth, $buttonHeight)
    $refreshButton.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 70)
    $refreshButton.ForeColor = [System.Drawing.Color]::White
    $refreshButton.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $refreshButton.FlatStyle = "Flat"
    $refreshButton.FlatAppearance.BorderSize = 1
    $refreshButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(100, 100, 110)
    $refreshButton.Cursor = [System.Windows.Forms.Cursors]::Hand
    $refreshButton.Add_MouseEnter({ $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(0, 180, 219) })
    $refreshButton.Add_MouseLeave({ $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(100, 100, 110) })
    $refreshButton.Add_Click({
        $global:PlatinumShellOutput.Clear()
        $global:PlatinumShellOutput.AppendText("Platinum+ Shell - Activity Monitor`r`n")
        $global:PlatinumShellOutput.AppendText("=========================================`r`n")
        $global:PlatinumShellOutput.AppendText("Log folder: " + $script:LogFilePath + "`r`n")
        $global:PlatinumShellOutput.AppendText("=========================================`r`n`r`n")
        
        $logFiles = Get-ChildItem -Path $script:LogFilePath -Filter "*.log" | Sort-Object LastWriteTime -Descending
        if ($logFiles.Count -eq 0) {
            $global:PlatinumShellOutput.AppendText("No log files found.`r`n")
        } else {
            $global:PlatinumShellOutput.AppendText("Log files ($($logFiles.Count)):`r`n")
            foreach ($file in $logFiles) {
                $global:PlatinumShellOutput.AppendText("  - $($file.Name) ($($file.LastWriteTime))`r`n")
            }
        }
        $global:PlatinumShellOutput.AppendText("=========================================`r`n`r`n")
    })
    $buttonPanel.Controls.Add($refreshButton)

    # Reset Data button
    $resetDataButton = New-Object System.Windows.Forms.Button
    $resetDataButton.Text = "Reset Data"
    $resetDataButton.Location = New-Object System.Drawing.Point(310, 10)
    $resetDataButton.Size = New-Object System.Drawing.Size($buttonWidth, $buttonHeight)
    $resetDataButton.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 70)
    $resetDataButton.ForeColor = [System.Drawing.Color]::White
    $resetDataButton.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $resetDataButton.FlatStyle = "Flat"
    $resetDataButton.FlatAppearance.BorderSize = 1
    $resetDataButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(100, 100, 110)
    $resetDataButton.Cursor = [System.Windows.Forms.Cursors]::Hand
    $resetDataButton.Add_MouseEnter({ $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(0, 180, 219) })
    $resetDataButton.Add_MouseLeave({ $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(100, 100, 110) })
    $resetDataButton.Add_Click({
        try {
            $configPath = "$ModuleRoot\config\state.json"
            if (Test-Path $configPath) {
                Remove-Item -Path $configPath -Force
                Write-PlatinumLog "Configuration data reset successfully (state.json deleted)" -Level "SUCCESS"
            } else {
                Write-PlatinumLog "Configuration file state.json does not exist." -Level "WARN"
            }
            
            if ($null -ne $global:PlatinumAppliedState) {
                $global:PlatinumAppliedState = @{}
            }
            
            # Force restart the program automatically
            Write-PlatinumLog "RESTARTING PROGRAM - Force shutdown and reload initiated..." -Level "INFO"
            $scriptPath = "$ModuleRoot\run.ps1"
            $psi = New-Object System.Diagnostics.ProcessStartInfo
            $psi.FileName = "powershell.exe"
            $psi.Arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`""
            $psi.Verb = "RunAs"
            $psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
            $psi.CreateNoWindow = $true
            [System.Diagnostics.Process]::Start($psi) | Out-Null
            
            # Force close the current process instantly
            Stop-Process -Id $PID -Force
        } catch {
            Write-PlatinumLog "Failed to reset data and restart: $($_.Exception.Message)" -Level "ERROR"
        }
    })
    $buttonPanel.Controls.Add($resetDataButton)

    # Kill program button
    $killButton = New-Object System.Windows.Forms.Button
    $killButton.Text = "Kill Program"
    $killButton.Location = New-Object System.Drawing.Point(460, 10)
    $killButton.Size = New-Object System.Drawing.Size($buttonWidth, $buttonHeight)
    $killButton.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 70)
    $killButton.ForeColor = [System.Drawing.Color]::White
    $killButton.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $killButton.FlatStyle = "Flat"
    $killButton.FlatAppearance.BorderSize = 1
    $killButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(100, 100, 110)
    $killButton.Cursor = [System.Windows.Forms.Cursors]::Hand
    $killButton.Add_MouseEnter({ $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(0, 180, 219) })
    $killButton.Add_MouseLeave({ $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(100, 100, 110) })
    $killButton.Add_Click({
        Write-PlatinumLog "KILLING PROGRAM - Force shutdown initiated" -Level "ERROR"
        Stop-Process -Id $PID -Force
    })
    $buttonPanel.Controls.Add($killButton)

    # Restart button
    $restartButton = New-Object System.Windows.Forms.Button
    $restartButton.Text = "Restart"
    $restartButton.Location = New-Object System.Drawing.Point(610, 10)
    $restartButton.Size = New-Object System.Drawing.Size($buttonWidth, $buttonHeight)
    $restartButton.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 70)
    $restartButton.ForeColor = [System.Drawing.Color]::White
    $restartButton.Font = New-Object System.Drawing.Font("Segoe UI", 9)
    $restartButton.FlatStyle = "Flat"
    $restartButton.FlatAppearance.BorderSize = 1
    $restartButton.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(100, 100, 110)
    $restartButton.Cursor = [System.Windows.Forms.Cursors]::Hand
    $restartButton.Add_MouseEnter({ $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(0, 180, 219) })
    $restartButton.Add_MouseLeave({ $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(100, 100, 110) })
    $restartButton.Add_Click({
        Write-PlatinumLog "RESTARTING PROGRAM - Restarting as Administrator" -Level "INFO"
        
        # Get current script path
        $scriptPath = "$ModuleRoot\run.ps1"
        
        # Restart as admin without showing PowerShell window
        $psi = New-Object System.Diagnostics.ProcessStartInfo
        $psi.FileName = "powershell.exe"
        $psi.Arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`""
        $psi.Verb = "RunAs"
        $psi.WindowStyle = [System.Diagnostics.ProcessWindowStyle]::Hidden
        $psi.CreateNoWindow = $true
        [System.Diagnostics.Process]::Start($psi) | Out-Null
        [Environment]::Exit(0)
    })
    $buttonPanel.Controls.Add($restartButton)

    # Handle shell close - close main program too instantly
    $shell.Add_FormClosing({
        Stop-Process -Id $PID -Force
    })

    # Store shell reference globally for future use
    $global:PlatinumShell = $shell
    $global:PlatinumShellOutput = $outputTextBox

    # Show the shell and immediately send it to back so it sits behind the main window
    $shell.Show()
    try {
        $shell.SendToBack()
    } catch {}

    # Write initial message to log
    Write-PlatinumLog "Platinum+ Shell initialized" -Level "INFO"
    Write-PlatinumLog "Log folder: $script:LogFilePath" -Level "INFO"
    
    # Show existing log files
    $logFiles = Get-ChildItem -Path $script:LogFilePath -Filter "*.log" | Sort-Object LastWriteTime -Descending
    if ($logFiles.Count -gt 0) {
        $global:PlatinumShellOutput.AppendText("Existing log files ($($logFiles.Count)):`r`n")
        foreach ($file in $logFiles) {
            $global:PlatinumShellOutput.AppendText("  - $($file.Name) ($($file.LastWriteTime))`r`n")
        }
        $global:PlatinumShellOutput.AppendText("========================================`r`n`r`n")
    }
}

function Write-PlatinumShellOutput {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )
    
    Write-PlatinumLog -Message $Message -Level $Level
}

function Close-PlatinumShell {
    if ($global:PlatinumShell) {
        Write-PlatinumLog "Platinum+ Shell closing" -Level "INFO"
        $global:PlatinumShell.Close()
    }
}

# Logging functions are now available globally after sourcing this file


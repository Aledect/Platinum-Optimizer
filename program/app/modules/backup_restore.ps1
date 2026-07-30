# Backup & Restore Event Handlers
$ui.FindName("BTN_CLEAR_RP").Add_Click({ Load-AppBackups; Show-CustomToast "Restore point inventory updated from the local backup vault." "Restore Points Updated" "Sync" })
$ui.FindName("BTN_CLEAR_REG").Add_Click({ Load-AppBackups; Show-CustomToast "Registry backup inventory updated from the local backup vault." "Registry Backups Updated" "Sync" })

# Info button hover effects
$btnInfoRP = $ui.FindName("BTN_INFO_RP")
if ($null -ne $btnInfoRP) {
    $btnInfoRP.Add_MouseEnter({
        $tb = [System.Windows.Controls.TextBlock]$this.Child
        if ($tb) { $tb.Foreground = "#00B4DB" }
    })
    $btnInfoRP.Add_MouseLeave({
        $tb = [System.Windows.Controls.TextBlock]$this.Child
        if ($tb) { $tb.Foreground = "#7B8498" }
    })
}

$btnInfoReg = $ui.FindName("BTN_INFO_REG")
if ($null -ne $btnInfoReg) {
    $btnInfoReg.Add_MouseEnter({
        $tb = [System.Windows.Controls.TextBlock]$this.Child
        if ($tb) { $tb.Foreground = "#00B4DB" }
    })
    $btnInfoReg.Add_MouseLeave({
        $tb = [System.Windows.Controls.TextBlock]$this.Child
        if ($tb) { $tb.Foreground = "#7B8498" }
    })
}

$ui.FindName("BTN_DO_CREATE_RP").Add_Click({
    $name = $ui.FindName("INP_RP_NAME").Text.Trim()
    if ($name -eq "") { $name = "RestorePoint_$(Get-Date -f 'yyyyMMdd_HHmmss')" }
    $backupDir = "$PSScriptRoot\..\tweak\01_backup\restore_point\restore"
    $path = "$backupDir\$name.txt"
    if (Test-Path $path) {
        Show-CustomPopup "A backup with this name already exists. Please choose a different name or delete the existing one first." "Duplicate Error" "Error"
        return
    }
    $origContent = $this.Content
    $this.Content = "Creating..."
    [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke("Render", [Action]{})
    
    # Log the action
    if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
        Log-ProgramAction -Action "Create Restore Point" -Details "Creating restore point: $name"
    }
    
    $batPath = "$PSScriptRoot\..\tweak\01_backup\restore_point\create_rp.ps1"
    if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
        Invoke-LoggedBat -BatPath $batPath -Arguments "-Name `"$name`"" | Out-Null
    }
    $this.Content = $origContent
    Load-AppBackups
    Show-CustomPopup "Your new configuration snapshot ($name) has been safely captured and written to disk." "Snapshot Created" "Success"
})

$ui.FindName("BTN_DO_APPLY_RP").Add_Click({
    $sel = $ui.FindName("LIST_RP").SelectedItem
    if ($sel) {
        # Log the action
        if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
            Log-ProgramAction -Action "Apply Restore Point" -Details "Applying restore point: $sel"
        }
        
        $batPath = "$PSScriptRoot\..\tweak\01_backup\restore_point\restore_rp.ps1"
        if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
            Invoke-LoggedBat -BatPath $batPath -Arguments "-FileName `"$sel`"" | Out-Null
        }
        Show-CustomPopup "System rollback logic dispatched for '$sel'. Your computer may automatically reboot to finalize the changes." "Rollback Triggered" "Success"
    } else {
        Show-CustomPopup "Please select an existing snapshot from the list below before executing a rollback." "Invalid Selection" "Error"
    }
})

$ui.FindName("BTN_DO_DEL_RP").Add_Click({
    $sel = $ui.FindName("LIST_RP").SelectedItem
    if ($sel) {
        # Log the action
        if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
            Log-ProgramAction -Action "Delete Restore Point" -Details "Deleting restore point: $sel"
        }
        
        $backupDir = "$PSScriptRoot\..\tweak\01_backup\restore_point\restore"
        $path = "$backupDir\$sel"
        if (Test-Path $path) {
            try {
                $content = Get-Content -Path $path -Raw
                $id = $null
                try {
                    $jsonParsed = $content | ConvertFrom-Json -ErrorAction Stop
                    if ($null -ne $jsonParsed.ID) { $id = [uint32]$jsonParsed.ID }
                } catch {
                    if ($content -match '^\d+$') { $id = [uint32]$content.Trim() }
                }
                if ($null -ne $id) {
                    [HardwareEngine]::SRRemoveRestorePoint($id) | Out-Null
                }
            } catch {
                # OS might have cleared it already, ignore
            }
            
            if (Test-Path $path) { Remove-Item -Path $path -Force }
            Load-AppBackups
            Show-CustomPopup "Restore point ($sel) successfully removed from the backup vault." "Deleted" "Success"
        }
    } else {
        Show-CustomPopup "Please select a snapshot to delete." "Action Failed" "Error"
    }
})

$ui.FindName("BTN_DO_CREATE_REG").Add_Click({
    $name = $ui.FindName("INP_REG_NAME").Text.Trim()
    if ($name -eq "") { $name = "RegistryBackup_$(Get-Date -f 'yyyyMMdd_HHmmss')" }
    $backupDir = "$PSScriptRoot\..\tweak\01_backup\registry_backup\registry"
    $path = "$backupDir\$name.reg"
    if (Test-Path $path) {
        Show-CustomPopup "A registry backup with this name already exists. Please choose a different name or delete it first." "Duplicate Error" "Error"
        return
    }
    $origContent = $this.Content
    $this.Content = "Exporting..."
    [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke("Render", [Action]{})
    
    # Log the action
    if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
        Log-ProgramAction -Action "Create Registry Backup" -Details "Creating registry backup: $name"
    }
    
    $batPath = "$PSScriptRoot\..\tweak\01_backup\registry_backup\create_reg.ps1"
    if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
        Invoke-LoggedBat -BatPath $batPath -Arguments "-Name `"$name`"" | Out-Null
    }
    $this.Content = $origContent
    Load-AppBackups
    Show-CustomPopup "A full export of your HKLM branch ($name) has been securely flushed to the backup vault." "Export Complete" "Success"
})

$ui.FindName("BTN_DO_APPLY_REG").Add_Click({
    $sel = $ui.FindName("LIST_REG").SelectedItem
    if ($sel) {
        # Log the action
        if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
            Log-ProgramAction -Action "Apply Registry Backup" -Details "Applying registry backup: $sel"
        }
        
        $batPath = "$PSScriptRoot\..\tweak\01_backup\registry_backup\restore_reg.ps1"
        if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
            Invoke-LoggedBat -BatPath $batPath -Arguments "-FileName `"$sel`"" | Out-Null
        }
        Show-CustomPopup "The registry tree ($sel) has been force-merged. Ensure you verified it before rebooting." "Merge Initialized" "Success"
    } else {
        Show-CustomPopup "Please highlight a local .reg dump from the view before attempting to merge." "Missing Parameter" "Error"
    }
})

$ui.FindName("BTN_DO_DEL_REG").Add_Click({
    $sel = $ui.FindName("LIST_REG").SelectedItem
    if ($sel) {
        # Log the action
        if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
            Log-ProgramAction -Action "Delete Registry Backup" -Details "Deleting registry backup: $sel"
        }
        
        $backupDir = "$PSScriptRoot\..\tweak\01_backup\registry_backup\registry"
        $path = "$backupDir\$sel"
        if (Test-Path $path) {
            Remove-Item -Path $path -Force
            Load-AppBackups
            Show-CustomPopup "Registry backup tree ($sel) permanently dropped from the disk vault." "Deleted" "Success"
        }
    } else {
        Show-CustomPopup "Please select a registry backup to delete." "Action Failed" "Error"
    }
})

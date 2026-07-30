# Navigation Event Handlers
$ui.FindName("NAV_HOME").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "MAIN" })
$ui.FindName("NAV_RESTORE").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "BACKUP"; Load-AppBackups })
$ui.FindName("NAV_BUGFIX").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "BUGFIX" })
$ui.FindName("NAV_DEBLOAT").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "DEBLOAT" })
$ui.FindName("NAV_SERVICE").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "SERVICES" })
$ui.FindName("NAV_SYS_TWEAKS").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "SYSTWEAKS" })
$ui.FindName("NAV_CLEANUP").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "CLEANUP" })
$ui.FindName("NAV_CPU").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "CPUTWEAKS" })
$ui.FindName("NAV_GPU").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "GPUTWEAKS" })
$ui.FindName("NAV_RAM").Add_Click({ 
    Set-Selector $this; Update-NavSelection $this; Show-View "RAMTWEAKS"
    $lblInfo = $ui.FindName("TXT_TWEAK_RAM_INFO")
    if ($lblInfo) {
        $os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($os) {
            $total = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
            $mem = Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue | Select-Object -First 1
            $smType = if ($mem.SMBIOSMemoryType -gt 0) { $mem.SMBIOSMemoryType } else { $mem.MemoryType }
            $ramType = switch ($smType) {
                24 { "DDR3" }
                26 { "DDR4" }
                34 { "DDR5" }
                20 { "DDR" }
                21 { "DDR2" }
                default { "RAM" }
            }
            $lblInfo.Text = "$total GB $ramType"
        }
    }
})
$ui.FindName("NAV_DISK").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "DISKTWEAKS" })
$ui.FindName("NAV_NET").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "NETTWEAKS" })
$ui.FindName("NAV_INPUT").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "INPUTTWEAKS" })
$ui.FindName("NAV_GAME").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "OTHER" })
$ui.FindName("NAV_ABOUT").Add_Click({ Set-Selector $this; Update-NavSelection $this; Show-View "ABOUT" })
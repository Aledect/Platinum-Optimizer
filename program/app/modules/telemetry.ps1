# Live Telemetry Timer (Live update every 1 second)
$global:BootTime = (Get-CimInstance Win32_OperatingSystem -Property LastBootUpTime -ErrorAction SilentlyContinue | Select-Object -First 1).LastBootUpTime

$global:TeleTimer = New-Object System.Windows.Threading.DispatcherTimer
$global:TeleTimer.Interval = [TimeSpan]::FromMilliseconds(1000)
$global:TeleTimer.Add_Tick({
    # KERNEL-LEVEL API CPU LOAD
    try {
        $cp = [math]::Round([HardwareEngine]::GetCpu(), 0)
        if ($cp -gt 100) { $cp = 100 }; if ($cp -lt 0) { $cp = 0 }
        $dCpuPct = $ui.FindName("TXT_CPU")
        if ($dCpuPct) { $dCpuPct.Text = "$cp" }
        
        $lblUse = $ui.FindName("TXT_TWEAK_CPU_USE")
        if ($lblUse) { $lblUse.Text = "$cp %" }
        $lblUseList = $ui.FindName("TXT_TWEAK_CPU_USE_LIST")
        if ($lblUseList) { $lblUseList.Text = "$cp %" }

        $lblGpuUseTweak = $ui.FindName("TXT_TWEAK_GPU_USE_VAL")
        if ($lblGpuUseTweak) { $lblGpuUseTweak.Text = "$([math]::Round($global:BgHash.GpuUse, 0)) %" }
        $lblGpuUseTweakList = $ui.FindName("TXT_TWEAK_GPU_USE_VAL_LIST")
        if ($lblGpuUseTweakList) { $lblGpuUseTweakList.Text = "$([math]::Round($global:BgHash.GpuUse, 0)) %" }

        $lblClock = $ui.FindName("TXT_TWEAK_CPU_CLOCK")
        if ($lblClock -and $global:BgHash.CpuClock -gt 0) {
            $lblClock.Text = "$([math]::Round($global:BgHash.CpuClock / 1000, 2)) GHz"
        }
        $lblClockList = $ui.FindName("TXT_TWEAK_CPU_CLOCK_LIST")
        if ($lblClockList -and $global:BgHash.CpuClock -gt 0) {
            $lblClockList.Text = "$([math]::Round($global:BgHash.CpuClock / 1000, 2)) GHz"
        }
        
        $lblRamUse = $ui.FindName("TXT_TWEAK_RAM_USE")
        if ($lblRamUse) {
            $rp = [HardwareEngine]::GetRam()
            $lblRamUse.Text = "$rp %"
        }
        
        $ringCpu = $ui.FindName("RING_CPU")
        if ($ringCpu) {
            $animRing = New-Object System.Windows.Media.Animation.DoubleAnimation
            $animRing.To = 43.9823 - ($cp / 100.0 * 43.9823)
            $animRing.Duration = [TimeSpan]::FromMilliseconds(500)
            $animRing.EasingFunction = New-Object System.Windows.Media.Animation.QuadraticEase
            $ringCpu.BeginAnimation([System.Windows.Shapes.Shape]::StrokeDashOffsetProperty, $animRing)
        }
    } catch {}

    # KERNEL-LEVEL API RAM LOAD
    try {
        $rp = [HardwareEngine]::GetRam()
        if ($rp -gt 100) { $rp = 100 }; if ($rp -lt 0) { $rp = 0 }
        $dRamPct = $ui.FindName("TXT_RAM")
        if ($dRamPct) { $dRamPct.Text = "$rp" }
        
        $lblRamTotal = $ui.FindName("TXT_RAM_USED_TOTAL")
        if ($lblRamTotal) {
            if (-not $global:TotRamMB -or $global:TotRamMB -le 0) {
                $osCim = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($osCim) { $global:TotRamMB = [math]::Round($osCim.TotalVisibleMemorySize / 1KB, 0) }
            }
            if ($global:TotRamMB -and $global:TotRamMB -gt 0) {
                $totGB = [math]::Round($global:TotRamMB / 1024, 1)
                $usedGB = [math]::Round($totGB * ($rp / 100.0), 1)
                $lblRamTotal.Text = "$usedGB / $totGB GB"
            }
        }

        $ringRam = $ui.FindName("RING_RAM")
        if ($ringRam) {
            $animRing = New-Object System.Windows.Media.Animation.DoubleAnimation
            $animRing.To = 43.9823 - ($rp / 100.0 * 43.9823)
            $animRing.Duration = [TimeSpan]::FromMilliseconds(500)
            $animRing.EasingFunction = New-Object System.Windows.Media.Animation.QuadraticEase
            $ringRam.BeginAnimation([System.Windows.Shapes.Shape]::StrokeDashOffsetProperty, $animRing)
        }
    } catch {}

    # ASYNC GPU LOAD
    try {
        $gu = $global:BgHash.GpuUse
        $dGpuPct = $ui.FindName("TXT_GPU_USE")
        if ($dGpuPct) { $dGpuPct.Text = "$([math]::Round($gu, 0))" }
        $ringGpu = $ui.FindName("RING_GPU")
        if ($ringGpu) {
            $animRing = New-Object System.Windows.Media.Animation.DoubleAnimation
            $animRing.To = 43.9823 - ($gu / 100.0 * 43.9823)
            $animRing.Duration = [TimeSpan]::FromMilliseconds(500)
            $animRing.EasingFunction = New-Object System.Windows.Media.Animation.QuadraticEase
            $ringGpu.BeginAnimation([System.Windows.Shapes.Shape]::StrokeDashOffsetProperty, $animRing)
        }
    } catch {}

    # ASYNC NETWORK STATS
    try {
        if ($global:BgHash.NetName) {
            $now = [DateTime]::Now
            $ts = ($now - $global:LastTick).TotalSeconds
            $txtDn = $ui.FindName("TXT_NET_DN")
            $txtUp = $ui.FindName("TXT_NET_UP")
            if ($ts -gt 0) {
                $syncRx = $global:BgHash.NetRx; $syncTx = $global:BgHash.NetTx
                if ($syncRx -ge $global:LastRx -and $syncTx -ge $global:LastTx) {
                    $rx_bytes = ($syncRx - $global:LastRx) / $ts
                    $tx_bytes = ($syncTx - $global:LastTx) / $ts
                    
                    $rx_bits = $rx_bytes * 8
                    $tx_bits = $tx_bytes * 8
                    
                    if ($rx_bits -gt 1000000) { $txtDn.Text = "$([math]::Round($rx_bits/1000000, 1)) Mbps" } 
                    else { $txtDn.Text = "$([math]::Round($rx_bits/1000, 0)) Kbps" }
                    
                    if ($tx_bits -gt 1000000) { $txtUp.Text = "$([math]::Round($tx_bits/1000000, 1)) Mbps" } 
                    else { $txtUp.Text = "$([math]::Round($tx_bits/1000, 0)) Kbps" }
                    
                    $lblNetDnTweak = $ui.FindName("TXT_TWEAK_NET_DN")
                    $lblNetUpTweak = $ui.FindName("TXT_TWEAK_NET_UP")
                    
                    if ($lblNetDnTweak) { $lblNetDnTweak.Text = $txtDn.Text }
                    if ($lblNetUpTweak) { $lblNetUpTweak.Text = $txtUp.Text }
                }
                $global:LastRx = $syncRx; $global:LastTx = $syncTx; $global:LastTick = $now
            }
        }
    } catch {}

    # NATIVE CORE OS INFO
    try {
        $txtProc = $ui.FindName("TXT_PROCS")
        if ($txtProc) { $txtProc.Text = "$([System.Diagnostics.Process]::GetProcesses().Length) Total" }
    } catch {}

    # UPTIME
    try {
        if ($global:BootTime) {
            $uptime = [DateTime]::Now - $global:BootTime
            $ui.FindName("TXT_UPTIME").Text = [string]::Format("{0:D2}:{1:D2}:{2:D2}", $uptime.Days * 24 + $uptime.Hours, $uptime.Minutes, $uptime.Seconds)
        }
    } catch {}

    # TEMPERATURES (LibreHardwareMonitor)
    try {
        $cpuTemp = $null
        $gpuTemp = $null
        $ssdTemp = $null
        $vramUsed = $null
        $vramTotal = $null

        if ($global:Computer) {
            foreach ($hw in $global:Computer.Hardware) {
                $hw.Update()
                foreach ($sub in $hw.SubHardware) {
                    $sub.Update()
                }

                # CPU Temperature (Priority: Core (Tctl/Tdie), then CCD1 (Tdie), then fallback)
                if ($hw.HardwareType -eq 'Cpu') {
                    $coreTemp = $null
                    $ccdTemp = $null
                    foreach ($s in $hw.Sensors) {
                        if ($s.SensorType -eq 'Temperature') {
                            if ($s.Name -eq 'Core (Tctl/Tdie)') {
                                $coreTemp = $s.Value
                            }
                            elseif ($s.Name -eq 'CCD1 (Tdie)') {
                                $ccdTemp = $s.Value
                            }
                        }
                    }
                    if ($null -ne $coreTemp) {
                        $cpuTemp = $coreTemp
                    } elseif ($null -ne $ccdTemp) {
                        $cpuTemp = $ccdTemp
                    } else {
                        # Generic CPU Temp fallback
                        foreach ($s in $hw.Sensors) {
                            if ($s.SensorType -eq 'Temperature' -and $s.Name -match 'Package|Core Average|Core') {
                                $cpuTemp = $s.Value
                                break
                            }
                        }
                    }
                }

                # GPU Temperature and VRAM
                if ($hw.HardwareType -eq 'GpuNvidia' -or $hw.HardwareType -eq 'GpuAmd' -or $hw.HardwareType -eq 'GpuIntel') {
                    foreach ($s in $hw.Sensors) {
                        if ($s.SensorType -eq 'Temperature' -and $s.Name -eq 'GPU Core') {
                            $gpuTemp = $s.Value
                        }
                        if ($s.Name -eq 'GPU Memory Total') {
                            $vramTotal = $s.Value
                        }
                        if ($s.Name -eq 'GPU Memory Used') {
                            $vramUsed = $s.Value
                        }
                    }
                    # GPU fallback sensor mapping if GPU Core is not found
                    if ($null -eq $gpuTemp) {
                        foreach ($s in $hw.Sensors) {
                            if ($s.SensorType -eq 'Temperature' -and $s.Name -match 'Core|GPU') {
                                $gpuTemp = $s.Value
                                break
                            }
                        }
                    }
                }

                # Disk Temperature (Composite Temperature, then fallback)
                if ($hw.HardwareType -eq 'Storage' -or $hw.HardwareType -eq 'Hdd') {
                    foreach ($s in $hw.Sensors) {
                        if ($s.SensorType -eq 'Temperature' -and $s.Name -eq 'Composite Temperature') {
                            $ssdTemp = $s.Value
                        }
                    }
                    if ($null -eq $ssdTemp) {
                        foreach ($s in $hw.Sensors) {
                            if ($s.SensorType -eq 'Temperature' -and $s.Name -match 'Temperature|Assembly|Composite') {
                                $ssdTemp = $s.Value
                                break
                            }
                        }
                    }
                }
            }
        }
        
        # AMD CPU fallback for CPU Temperature if LHM didn't catch it
        if ($null -eq $cpuTemp -and $global:BgHash.IsAmdCpu) {
            # Only use AMD-SMI data if it provided a valid response
            if ($global:BgHash.AmdCpuTempValid) {
                $amdTemp = $global:BgHash.AmdCpuTemp
                if ($amdTemp -ge 0) {
                    $cpuTemp = $amdTemp
                }
            }
        }
        # Intel CPU fallback for CPU Temperature if LHM didn't catch it
        if ($null -eq $cpuTemp -and $global:BgHash.IsIntelCpu) {
            # Use OpenHardwareMonitor first if available
            if ($global:BgHash.IntelCpuTempValid) {
                $intelTemp = $global:BgHash.IntelCpuTemp
                if ($intelTemp -ge 0) {
                    $cpuTemp = $intelTemp
                }
            }
            # If OpenHwMon didn't work, try LibreHardwareMonitor
            if ($null -eq $cpuTemp -and $global:BgHash.LibreIntelCpuTempValid) {
                $libreTemp = $global:BgHash.LibreIntelCpuTemp
                if ($libreTemp -ge 0) {
                    $cpuTemp = $libreTemp
                }
            }
            # If both available, average them for better accuracy
            if ($global:BgHash.IntelCpuTempValid -and $global:BgHash.LibreIntelCpuTempValid) {
                $temp1 = $global:BgHash.IntelCpuTemp
                $temp2 = $global:BgHash.LibreIntelCpuTemp
                if ($temp1 -ge 0 -and $temp2 -ge 0) {
                    $cpuTemp = ($temp1 + $temp2) / 2
                }
            }
        }
        
        # Universal multi-thread background fallback for CPU Temperature (Intel / AMD / WMI)
        if ((-not $cpuTemp -or $cpuTemp -le 0) -and $global:BgHash.CpuTemp -and $global:BgHash.CpuTemp -gt 0) {
            $cpuTemp = $global:BgHash.CpuTemp
        }
        
        # Nvidia background SMI fallback for GPU Temperature if LHM didn't catch it
        if ($null -eq $gpuTemp -and $global:BgHash.IsNvidia) {
            # Only use nvidia-smi data if it provided a valid response
            if ($global:BgHash.NvidiaGpuTempValid) {
                $nvidiaTemp = $global:BgHash.NvidiaTemp
                if ($nvidiaTemp -ge 0) {
                    $gpuTemp = $nvidiaTemp
                }
            }
        }
        # AMD GPU fallback for GPU Temperature if LHM didn't catch it
        if ($null -eq $gpuTemp -and $global:BgHash.IsAmdGpu) {
            # Only use amd-smi data if it provided a valid response
            if ($global:BgHash.AmdGpuTempValid) {
                $amdTemp = $global:BgHash.AmdTemp
                if ($amdTemp -ge 0) {
                    $gpuTemp = $amdTemp
                }
            }
        }
        # Intel GPU fallback for GPU Temperature if LHM didn't catch it
        if ($null -eq $gpuTemp -and $global:BgHash.IsIntelGpu) {
            # Only use Intel data if it provided a valid response
            if ($global:BgHash.IntelGpuTempValid) {
                $intelTemp = $global:BgHash.IntelTemp
                if ($intelTemp -ge 0) {
                    $gpuTemp = $intelTemp
                }
            }
        }

        $degree = [string][char]176

        # Update the new text controls requested by the user
        $txtCpuTempReq = $ui.FindName("TXT_CPU_TEMP")
        if ($txtCpuTempReq) {
            if ($null -ne $cpuTemp -and $cpuTemp -gt 0) {
                $txtCpuTempReq.Text = "$([math]::Round($cpuTemp, 1))$degree" + "C"
            } else {
                $txtCpuTempReq.Text = "--$degree" + "C"
            }
        }

        $txtGpuTempReq = $ui.FindName("TXT_GPU_TEMP")
        if ($txtGpuTempReq) {
            if ($null -ne $gpuTemp) {
                $txtGpuTempReq.Text = "$([math]::Round($gpuTemp, 1))$degree" + "C"
            } else {
                $txtGpuTempReq.Text = "--$degree" + "C"
            }
        }

        $txtTweakCpuTemp = $ui.FindName("TXT_TWEAK_CPU_TEMP")
        if ($txtTweakCpuTemp) {
            if ($null -ne $cpuTemp -and $cpuTemp -gt 0) {
                $txtTweakCpuTemp.Text = "$([math]::Round($cpuTemp, 1))$degree" + "C"
            } else {
                $txtTweakCpuTemp.Text = "--$degree" + "C"
            }
        }
        $txtTweakCpuTempList = $ui.FindName("TXT_TWEAK_CPU_TEMP_LIST")
        if ($txtTweakCpuTempList) {
            if ($null -ne $cpuTemp -and $cpuTemp -gt 0) {
                $txtTweakCpuTempList.Text = "$([math]::Round($cpuTemp, 1))$degree" + "C"
            } else {
                $txtTweakCpuTempList.Text = "--$degree" + "C"
            }
        }

        $txtTweakGpuTemp = $ui.FindName("TXT_TWEAK_GPU_TEMP")
        if ($txtTweakGpuTemp) {
            if ($null -ne $gpuTemp) {
                $txtTweakGpuTemp.Text = "$([math]::Round($gpuTemp, 1))$degree" + "C"
            } else {
                $txtTweakGpuTemp.Text = "--$degree" + "C"
            }
        }
        $txtTweakGpuTempList = $ui.FindName("TXT_TWEAK_GPU_TEMP_LIST")
        if ($txtTweakGpuTempList) {
            if ($null -ne $gpuTemp) {
                $txtTweakGpuTempList.Text = "$([math]::Round($gpuTemp, 1))$degree" + "C"
            } else {
                $txtTweakGpuTempList.Text = "--$degree" + "C"
            }
        }

        $txtSsdTempReq = $ui.FindName("TXT_SSD_TEMP")
        if ($txtSsdTempReq) {
            if ($null -ne $ssdTemp) {
                $txtSsdTempReq.Text = "$([math]::Round($ssdTemp, 1))$degree" + "C"
            } else {
                $txtSsdTempReq.Text = "--$degree" + "C"
            }
        }

        $txtVramReq = $ui.FindName("TXT_VRAM")
        $txtGpuVramTweak = $ui.FindName("TXT_TWEAK_GPU_VRAM_VAL")
        $txtGpuVramTweakList = $ui.FindName("TXT_TWEAK_GPU_VRAM_VAL_LIST")
        
        $vramText = "-- / -- GB"
        $vramTotalText = "-- GB"
        
        if ($null -ne $vramUsed -and $null -ne $vramTotal) {
            $vramText = ("{0:N1} / {1:N1} GB" -f ($vramUsed / 1024.0), ($vramTotal / 1024.0))
            $vramTotalText = ("{0:N1} GB" -f ($vramTotal / 1024.0))
        } else {
            # Fallback to Nvidia SMI background data if LHM is not reporting VRAM
            if ($global:BgHash.NvidiaVramUsed -gt 0 -and $global:BgHash.NvidiaVramTotal -gt 0) {
                $vramText = ("{0:N1} / {1:N1} GB" -f ($global:BgHash.NvidiaVramUsed / 1024.0), ($global:BgHash.NvidiaVramTotal / 1024.0))
                $vramTotalText = ("{0:N1} GB" -f ($global:BgHash.NvidiaVramTotal / 1024.0))
            }
            # Fallback to AMD SMI
            elseif ($global:BgHash.AmdVramUsed -gt 0 -and $global:BgHash.AmdVramTotal -gt 0) {
                $vramText = ("{0:N1} / {1:N1} GB" -f ($global:BgHash.AmdVramUsed / 1024.0), ($global:BgHash.AmdVramTotal / 1024.0))
                $vramTotalText = ("{0:N1} GB" -f ($global:BgHash.AmdVramTotal / 1024.0))
            }
        }
        
        if ($txtVramReq) { $txtVramReq.Text = $vramText }
        if ($txtGpuVramTweak) { $txtGpuVramTweak.Text = $vramTotalText }
        if ($txtGpuVramTweakList) { $txtGpuVramTweakList.Text = $vramTotalText }

        # Maintain existing UI temperature controls.
        $cpuDisplayTemp = if ($null -ne $cpuTemp -and $cpuTemp -gt 0) { [math]::Round($cpuTemp, 0) } else { "--" }
        $gpuDisplayTemp = if ($null -ne $gpuTemp) { [math]::Round($gpuTemp, 0) } else { "--" }

        $txtCpuTemp = $ui.FindName("TXT_TEMP_CPU")
        if ($txtCpuTemp) { $txtCpuTemp.Text = "CPU: $cpuDisplayTemp$degree" + "C" }
        $txtGpuTemp = $ui.FindName("TXT_TEMP_GPU")
        if ($txtGpuTemp) { $txtGpuTemp.Text = "GPU: $gpuDisplayTemp$degree" + "C" }
        
        $txtCpuTempCard = $ui.FindName("TXT_TEMP_CPU_CARD")
        if ($txtCpuTempCard) { $txtCpuTempCard.Text = "Temp: $cpuDisplayTemp$degree" + "C" }
        $txtGpuTempCard = $ui.FindName("TXT_TEMP_GPU_CARD")
        if ($txtGpuTempCard) { $txtGpuTempCard.Text = "Temp: $gpuDisplayTemp$degree" + "C" }
    } catch {}

    # TOP 5 PROCESSES
    try {
        $procsJson = $global:BgHash.TopProcs
        if ($procsJson) {
            $procs = $procsJson | ConvertFrom-Json
            $i = 1
            foreach ($p in $procs) {
                if ($i -le 5) {
                    $ui.FindName("TXT_TOP_PROC_$($i)_NAME").Text = $p.Name
                    $ui.FindName("TXT_TOP_PROC_$($i)_VAL").Text = "$([math]::Round($p.CPU, 1))s"
                    $i++
                }
            }
        }
    } catch {}

    # LIVE GRAPH
    try {
        if ($global:CpuHistory -and $global:CpuHistory.Count -gt 0) {
            $global:CpuHistory.RemoveAt(0)
            $global:CpuHistory.Add($cp)
            $global:RamHistory.RemoveAt(0)
            $global:RamHistory.Add($rp)
            $global:GpuHistory.RemoveAt(0)
            $global:GpuHistory.Add($gu)

            $canvas = $ui.FindName("CANVAS_GRAPH")
            if ($canvas -and $canvas.ActualWidth -gt 0 -and $canvas.ActualHeight -gt 0) {
                $w = $canvas.ActualWidth
                $h = $canvas.ActualHeight
                
                $cpuPoints = New-Object System.Windows.Media.PointCollection
                $ramPoints = New-Object System.Windows.Media.PointCollection
                $gpuPoints = New-Object System.Windows.Media.PointCollection

                $step = $w / ($global:GraphMaxPoints - 1)
                for ($i = 0; $i -lt $global:GraphMaxPoints; $i++) {
                    $x = $i * $step
                    $cpuY = $h - ($global:CpuHistory[$i] / 100.0 * $h)
                    $ramY = $h - ($global:RamHistory[$i] / 100.0 * $h)
                    $gpuY = $h - ($global:GpuHistory[$i] / 100.0 * $h)
                    
                    $cpuPoints.Add((New-Object System.Windows.Point($x, $cpuY)))
                    $ramPoints.Add((New-Object System.Windows.Point($x, $ramY)))
                    $gpuPoints.Add((New-Object System.Windows.Point($x, $gpuY)))
                }
                
                $ui.FindName("LINE_CPU_GRAPH").Points = $cpuPoints
                $ui.FindName("LINE_RAM_GRAPH").Points = $ramPoints
                $ui.FindName("LINE_GPU_GRAPH").Points = $gpuPoints
            }
        }
    } catch {}
})

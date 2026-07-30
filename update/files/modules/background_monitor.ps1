# Multi-threading Background Engine (Zero UI Lag)
$global:BgHash = [hashtable]::Synchronized(@{
    GpuUse = 0; NetRx = 0; NetTx = 0; NetName = $null; IsRunning = $true; CpuClock = 0;
    NvidiaVramUsed = 0; NvidiaVramTotal = 0; NvidiaTemp = 0; TopProcs = $null; IsNvidia = $false;
    CpuTemp = 0; GpuTemp = 0; RamUse = 0
})

$global:BgRs = [runspacefactory]::CreateRunspace()
$global:BgRs.Open()
$global:BgRs.SessionStateProxy.SetVariable("bgHash", $global:BgHash)
$global:BgRs.SessionStateProxy.SetVariable("scriptRoot", $PSScriptRoot)

$global:BgPs = [powershell]::Create().AddScript({
    # --- CARICAMENTO DLL DENTRO IL RUNSPACE ---
    $appBase = (Get-Item $scriptRoot).Parent.FullName
    $libreDll = Join-Path $appBase "libs\LibreHardwareMonitor\LibreHardwareMonitorLib.dll"
    $openDll  = Join-Path $appBase "libs\OpenHardwareMonitor\OpenHardwareMonitorLib.dll"
    if (Test-Path $libreDll) { try { Add-Type -Path $libreDll } catch {} }
    if (Test-Path $openDll)  { try { Add-Type -Path $openDll } catch {} }

    $cpuCim = Get-CimInstance Win32_Processor -Property MaxClockSpeed -ErrorAction SilentlyContinue | Select-Object -First 1
    $maxClock = if ($cpuCim) { $cpuCim.MaxClockSpeed } else { 0 }
    
    $nvidiaSmi = "C:\Windows\System32\nvidia-smi.exe" 
    $hasNvidia = Test-Path $nvidiaSmi

    # Inizializzazione Librerie Hardware
    $libreComp = $null; $openComp = $null
    try { 
        $libreComp = New-Object LibreHardwareMonitor.Hardware.Computer
        $libreComp.IsCpuEnabled = $true; $libreComp.IsGpuEnabled = $true; $libreComp.IsMemoryEnabled = $true; $libreComp.IsMotherboardEnabled = $true; $libreComp.IsControllerEnabled = $true
        $libreComp.Open() 
        if ($libreComp.Hardware.Count -eq 0) { $libreComp = $null }
    } catch { $libreComp = $null }
    
    try { 
        $openComp = New-Object OpenHardwareMonitor.Hardware.Computer
        $openComp.CPUEnabled = $true; $openComp.RAMEnabled = $true; $openComp.GPUEnabled = $true; $openComp.MainboardEnabled = $true; $openComp.FanEnabled = $true
        $openComp.Open() 
        if ($openComp.Hardware.Count -eq 0) { $openComp = $null }
    } catch { $openComp = $null }

    # Funzione Robust (Open -> Libre -> WMI ACPI) per CPU Temp
    function Get-SafeCpuTemp {
        $priorityPatterns = @('CPU Package', 'CPU CCD #1', 'CCD1 (Tdie)', 'Core (Tctl/Tdie)', 'CPU Core', 'Package', 'Core Average', 'Tctl/Tdie')
        $comps = @($openComp, $libreComp)
        foreach ($comp in $comps) {
            if (-not $comp) { continue }
            try {
                foreach ($hw in $comp.Hardware) {
                    $hw.Update()
                    foreach ($sub in $hw.SubHardware) { $sub.Update() }
                    
                    foreach ($pattern in $priorityPatterns) {
                        foreach ($s in $hw.Sensors) {
                            if ($s.SensorType.ToString() -eq 'Temperature' -and ($s.Name -eq $pattern -or $s.Name -like "*$pattern*")) {
                                if ($null -ne $s.Value -and [double]$s.Value -gt 10 -and [double]$s.Value -lt 125) {
                                    return [double]$s.Value
                                }
                            }
                        }
                    }
                    foreach ($sub in $hw.SubHardware) {
                        foreach ($pattern in $priorityPatterns) {
                            foreach ($s in $sub.Sensors) {
                                if ($s.SensorType.ToString() -eq 'Temperature' -and ($s.Name -eq $pattern -or $s.Name -like "*$pattern*")) {
                                    if ($null -ne $s.Value -and [double]$s.Value -gt 10 -and [double]$s.Value -lt 125) {
                                        return [double]$s.Value
                                    }
                                }
                            }
                        }
                    }
                    foreach ($s in $hw.Sensors) {
                        if ($s.SensorType.ToString() -eq 'Temperature') {
                            if ($null -ne $s.Value -and [double]$s.Value -gt 10 -and [double]$s.Value -lt 125) {
                                return [double]$s.Value
                            }
                        }
                    }
                }
            } catch {}
        }
        # WMI ACPI Fallback
        try {
            $acpi = Get-CimInstance -Namespace root/wmi -ClassName MSAcpi_ThermalZoneTemperature -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($acpi -and $acpi.CurrentTemperature -gt 2731) {
                $c = ($acpi.CurrentTemperature / 10.0) - 273.15
                if ($c -gt 10 -and $c -lt 125) { return [double]$c }
            }
        } catch {}
        return $null
    }

    # Funzione Fallback (Open -> Libre)
    function Get-SafeSensorValue {
        param([string]$SenType, [string]$SenName = "")
        $val = $null
        $comps = @($openComp, $libreComp)
        foreach ($comp in $comps) {
            if ($comp) {
                try {
                    foreach ($hw in $comp.Hardware) {
                        $hw.Update()
                        foreach ($s in $hw.Sensors) {
                            if ($s.SensorType.ToString() -eq $SenType) {
                                if ($SenName -eq "" -or $s.Name -like "*$SenName*") {
                                    if ($null -ne $s.Value -and [double]$s.Value -gt 0) { 
                                        $val = [double]$s.Value
                                        break 
                                    }
                                }
                            }
                        }
                        if ($val) { break }
                    }
                } catch {}
            }
            if ($val) { break } 
        }
        return $val
    }

    while($bgHash.IsRunning) {
        try {
            $perfCounter = Get-Counter "\Processor Information(_Total)\% Processor Performance" -ErrorAction SilentlyContinue
            if ($perfCounter -and $maxClock -gt 0) {
                $bgHash.CpuClock = $maxClock * ($perfCounter.CounterSamples[0].CookedValue / 100.0)
            } else {
                $m = Get-CimInstance Win32_Processor -Property CurrentClockSpeed -ErrorAction SilentlyContinue | Select-Object -First 1
                if ($m -and $m.CurrentClockSpeed) { $bgHash.CpuClock = $m.CurrentClockSpeed }
            }
        } catch {}
        
        try {
            $procs = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 Name, CPU, Id | ConvertTo-Json -Compress
            $bgHash.TopProcs = $procs
        } catch {}

        try {
            if ($bgHash.IsNvidia -and $hasNvidia) {
                $smiOut = & $nvidiaSmi --query-gpu=utilization.gpu,memory.used,memory.total,temperature.gpu --format=csv,noheader,nounits -ErrorAction SilentlyContinue
                if ($smiOut) {
                    $parts = $smiOut -split ','
                    if ($parts.Count -ge 4) {
                        $bgHash.GpuUse = [double]$parts[0].Trim()
                        $bgHash.NvidiaVramUsed = [double]$parts[1].Trim()
                        $bgHash.NvidiaVramTotal = [double]$parts[2].Trim()
                        $bgHash.NvidiaTemp = [double]$parts[3].Trim()
                    }
                }
            } else {
                $gu = 0
                $gpus = Get-Counter "\GPU Engine(*engtype_3D)\Utilization Percentage" -ErrorAction SilentlyContinue
                if ($gpus) { foreach ($v in $gpus.CounterSamples) { $gu += $v.CookedValue } }
                if ($gu -gt 100) { $gu = 100 }
                $bgHash.GpuUse = $gu
            }
        } catch {}

        # --- LETTURE TEMPERATURE E MEMORIA ---
        try {
            $cpuT = Get-SafeCpuTemp
            $bgHash.CpuTemp = if ($null -ne $cpuT) { $cpuT } else { 0 }

            if (-not $bgHash.IsNvidia -or $bgHash.NvidiaTemp -eq 0) {
                $gpuT = Get-SafeSensorValue -SenType 'Temperature' -SenName 'GPU'
                $bgHash.GpuTemp = if ($gpuT) { $gpuT } else { 0 }
            } else {
                $bgHash.GpuTemp = $bgHash.NvidiaTemp
            }
        } catch {}

        if ($bgHash.NetName) {
            try {
                $ns = Get-NetAdapterStatistics -Name $bgHash.NetName -ErrorAction SilentlyContinue
                if ($ns) { $bgHash.NetRx = $ns.ReceivedBytes; $bgHash.NetTx = $ns.SentBytes }
            } catch {}
        }
        Start-Sleep -Seconds 2
    }
})

$global:BgPs.Runspace = $global:BgRs
$global:BgJob = $global:BgPs.BeginInvoke()
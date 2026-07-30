# System Information Collection
# CPU Vendor Check & Dynamic Tweak Generation
$global:CpuVendorIsAmd = $false
$c = Get-CimInstance Win32_Processor -ErrorAction SilentlyContinue | Select-Object -First 1
if ($c) {
    $ui.FindName("TXT_CPU_NAME").Text = $c.Name
    $f = $ui.FindName("TXT_CPU_FREQ"); if ($f) { $f.Text = "$([math]::Round($c.MaxClockSpeed/1000, 2)) GHz" }
    $b = [char]0x2022
    $ct = $ui.FindName("TXT_CPU_CT"); if ($ct) { $ct.Text = "$($c.NumberOfCores) Cores / $($c.NumberOfLogicalProcessors) Threads" }
    $cpuCtText = "$($c.NumberOfCores) Cores $b $($c.NumberOfLogicalProcessors) Threads $b $([math]::Round($c.MaxClockSpeed/1000, 2)) GHz Base"
    $tweakCpuCt = $ui.FindName("TXT_TWEAK_CPU_CT"); if ($tweakCpuCt) { $tweakCpuCt.Text = $cpuCtText }
    $tweakCpuCtList = $ui.FindName("TXT_TWEAK_CPU_CT_LIST"); if ($tweakCpuCtList) { $tweakCpuCtList.Text = $cpuCtText }
    
    $tweakCpuName = $ui.FindName("TXT_TWEAK_CPU_NAME")
    if ($tweakCpuName) { $tweakCpuName.Text = $c.Name }
    $tweakCpuNameList = $ui.FindName("TXT_TWEAK_CPU_NAME_LIST")
    if ($tweakCpuNameList) { $tweakCpuNameList.Text = $c.Name }
    $vendorImg = $ui.FindName("IMG_CPU_VENDOR")
    $vendorImgList = $ui.FindName("IMG_CPU_VENDOR_LIST")
    if ($vendorImg) {
        if ($c.Manufacturer -match "AMD|Advanced Micro Devices") {
            $global:CpuVendorIsAmd = $true
            $vendorImg.Source = $global:AmdIco
            if ($vendorImgList) { $vendorImgList.Source = $global:AmdIco }
            
            $t1Title = $ui.FindName("TXT_CPU_TITLE_1"); if ($t1Title) { $t1Title.Text = "Enable Precision Boost Overdrive" }
            $t1Desc  = $ui.FindName("TXT_CPU_DESC_1"); if ($t1Desc) { $t1Desc.Text = "Unlocks power limits (PPT, TDC, EDC) allowing Ryzen processors to boost higher and longer." }
            
            $t2Title = $ui.FindName("TXT_CPU_TITLE_2"); if ($t2Title) { $t2Title.Text = "Disable CPPC Preferred Cores" }
            $t2Desc  = $ui.FindName("TXT_CPU_DESC_2"); if ($t2Desc) { $t2Desc.Text = "Forces Windows to balance threads across all cores rather than hammering the 'best' cores natively." }
            
            $t3Title = $ui.FindName("TXT_CPU_TITLE_3"); if ($t3Title) { $t3Title.Text = "Optimize CCX/CCD Latency" }
            $t3Desc  = $ui.FindName("TXT_CPU_DESC_3"); if ($t3Desc) { $t3Desc.Text = "Adjusts Windows scheduler to prefer keeping threads within the same CCX to significantly reduce L3 cache misses." }

            $t4Title = $ui.FindName("TXT_CPU_TITLE_4"); if ($t4Title) { $t4Title.Text = "Disable CPU Meltdown Patches" }
            $t4Desc  = $ui.FindName("TXT_CPU_DESC_4"); if ($t4Desc) { $t4Desc.Text = "Disables hardware-level mitigations like Spectre, recovering significant performance overhead." }

            $t5Title = $ui.FindName("TXT_CPU_TITLE_5"); if ($t5Title) { $t5Title.Text = "Enable AMD Ryzen Balanced Power" }
            $t5Desc  = $ui.FindName("TXT_CPU_DESC_5"); if ($t5Desc) { $t5Desc.Text = "Forces aggressive immediate P-State transitions while still downclocking at idle for optimal thermals." }
        } else {
            $global:CpuVendorIsAmd = $false
            $vendorImg.Source = $global:IntelIco
            if ($vendorImgList) { $vendorImgList.Source = $global:IntelIco }
            
            $t1Title = $ui.FindName("TXT_CPU_TITLE_1"); if ($t1Title) { $t1Title.Text = "Optimize Intel Thread Director" }
            $t1Desc  = $ui.FindName("TXT_CPU_DESC_1"); if ($t1Desc) { $t1Desc.Text = "Prioritizes heavy gaming workloads exclusively onto Performance Cores (P-Cores) for Alder/Raptor Lake." }
            
            $t2Title = $ui.FindName("TXT_CPU_TITLE_2"); if ($t2Title) { $t2Title.Text = "Disable Intel SpeedStep" }
            $t2Desc  = $ui.FindName("TXT_CPU_DESC_2"); if ($t2Desc) { $t2Desc.Text = "Locks CPU at maximum turbo states preventing unwanted frequency dips and drops during active sessions." }

            $t3Title = $ui.FindName("TXT_CPU_TITLE_3"); if ($t3Title) { $t3Title.Text = "Disable Deep C-States (Idle States)" }
            $t3Desc  = $ui.FindName("TXT_CPU_DESC_3"); if ($t3Desc) { $t3Desc.Text = "Restricts processor deep idle power states (C6/C7) to improve wake-up times and decrease DPC latency." }

            $t4Title = $ui.FindName("TXT_CPU_TITLE_4"); if ($t4Title) { $t4Title.Text = "Disable CPU Meltdown Patches" }
            $t4Desc  = $ui.FindName("TXT_CPU_DESC_4"); if ($t4Desc) { $t4Desc.Text = "Disables Intel-specific hardware mitigations, recovering native processing capabilities overhead." }

            $t5Title = $ui.FindName("TXT_CPU_TITLE_5"); if ($t5Title) { $t5Title.Text = "Enable Ultimate Performance Mode" }
            $t5Desc  = $ui.FindName("TXT_CPU_DESC_5"); if ($t5Desc) { $t5Desc.Text = "Unlocks the hidden Windows Ultimate profile specifically designed for zero micro-latency workloads." }
        }
    }
}


# OS Information
$o = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue | Select-Object -First 1
if ($o) {
    $ui.FindName("TXT_OS_NAME").Text = $o.Caption
    $global:TotRamMB = [math]::Round($o.TotalVisibleMemorySize / 1KB, 0)
    $rgb = $ui.FindName("TXT_RAM_GB"); if ($rgb) { $rgb.Text = "$([math]::Round($global:TotRamMB / 1024, 1)) GB Total" }

    $osVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ErrorAction SilentlyContinue).DisplayVersion
    if (-not $osVersion) { $osVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -ErrorAction SilentlyContinue).ReleaseId }
    
    $osNameTxt = $ui.FindName("TXT_TWEAK_OS_NAME"); if ($osNameTxt) { $osNameTxt.Text = $o.Caption }
    $osVerTxt  = $ui.FindName("TXT_TWEAK_OS_VERSION"); if ($osVerTxt) { $osVerTxt.Text = $osVersion }
    $osBuildTxt = $ui.FindName("TXT_TWEAK_OS_BUILD"); if ($osBuildTxt) { $osBuildTxt.Text = $o.Version }
    
    $osLogoImg = $ui.FindName("IMG_OS_LOGO")
    if ($osLogoImg) {
        if ($o.Caption -match "Windows 11") {
            $osLogoImg.Source = $global:Win11Ico
        } else {
            $osLogoImg.Source = $global:Win10Ico
        }
    }
}

# RAM Info
$m = Get-CimInstance Win32_PhysicalMemory -ErrorAction SilentlyContinue | Select-Object -First 1
if ($m) { 
    $rmhz = $ui.FindName("TXT_RAM_MHZ"); if ($rmhz) { $rmhz.Text = "Speed: $($m.Speed) MHz" }
    $sm = $m.SMBIOSMemoryType
    $rtype = $ui.FindName("TXT_RAM_TYPE"); if ($rtype) { $rtype.Text = switch ($sm) { 24 {"DDR3"} 26 {"DDR4"} 34 {"DDR5"} default {"RAM Module"} } }
}

# GPU Info
$g = Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue | Select-Object -First 1
if ($g) {
    $ui.FindName("TXT_GPU_NAME").Text = $g.Name
    $gres = $ui.FindName("TXT_GPU_RES"); if ($gres) { $gres.Text = "Res: $($g.CurrentHorizontalResolution) x $($g.CurrentVerticalResolution)" }
    $ghz = $ui.FindName("TXT_GPU_HZ"); if ($ghz) { $ghz.Text = "Refresh: $($g.CurrentRefreshRate) Hz" }
    
    $vr = [math]::Round($g.AdapterRAM / 1GB, 1)
    $gvram = $ui.FindName("TXT_GPU_VRAM")
    if ($gvram) {
        if ($vr -gt 0) { $gvram.Text = "VRAM: $vr GB" }
        else { $gvram.Text = "VRAM: N/A" }
    }
}

# Primary Network Adapter (Home + Network Optimization)
try {
    $primaryNet = Get-PrimaryNetworkAdapter
    if ($primaryNet) {
        $adapter = $primaryNet.Adapter
        $displayName = $adapter.InterfaceDescription
        $lblHome = $ui.FindName("TXT_NET_NAME"); if ($lblHome) { $lblHome.Text = $displayName }
        $lblTweak = $ui.FindName("TXT_TWEAK_NET_NAME"); if ($lblTweak) { $lblTweak.Text = $displayName }

        $netIcon = $ui.FindName("IMG_NET_TWEAK")
        if ($netIcon) {
            if ($primaryNet.ConnectionType -eq 'Ethernet') {
                $netIcon.Source = $global:EthernetTweakIco
                $netIcon.Width = 46
                $netIcon.Height = 46
            } else {
                $netIcon.Source = $global:WifiIco
                $netIcon.Width = 36
                $netIcon.Height = 36
            }
        }

        $global:BgHash.NetName = $adapter.Name
        $ns = Get-NetAdapterStatistics -Name $adapter.Name -ErrorAction SilentlyContinue
        if ($ns) {
            $global:LastRx = $ns.ReceivedBytes
            $global:LastTx = $ns.SentBytes
            $global:BgHash.NetRx = $ns.ReceivedBytes
            $global:BgHash.NetTx = $ns.SentBytes
            $global:LastTick = [DateTime]::Now
        }
    }
} catch {}

# Kernel Init Trigger
[HardwareEngine]::GetCpu() | Out-Null

# Disk Info
$d = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'" -ErrorAction SilentlyContinue | Select-Object -First 1
if ($d) {
    $ui.FindName("TXT_DISK_VOL").Text = "Drive C: ($($d.FileSystem))"
    $dt = [math]::Round($d.Size / 1GB, 1); $df = [math]::Round($d.FreeSpace / 1GB, 1)
    $du = [math]::Round($dt-$df, 1)
    $ui.FindName("TXT_DISK_USE").Text = "$du GB"
    $ui.FindName("TXT_DISK_FREE").Text = "$df GB free of $dt GB"
    
    $barDisk = $ui.FindName("BAR_DISK")
    if ($barDisk -and $dt -gt 0) {
        $pct = ($du / $dt) * 100
        # Assume max width of the container is approx 120px for the progress bar (or we can use relative sizing if parent is stretched)
        # We will set a scale transform or width directly. Let's just set the width to a percentage of 200px (assuming full width is 200)
        # Actually it's better to set width directly, parent border has no fixed width so it's stretch. But BAR_DISK is inside a Border with Height=4.
        # Let's bind its width later in telemetry, or set a fixed max width.
        # Let's just set width to $pct * 2 since Max width could be 200
        $barDisk.Width = $pct * 1.5
    }

    # Disk Optimization Section Initialization
    $diskType = "Disk"
    try {
        $pDisk = Get-PhysicalDisk -ErrorAction SilentlyContinue | Select-Object MediaType | Select-Object -First 1
        if ($pDisk) {
            $diskType = $pDisk.MediaType
        }
    } catch {}

    $tweakDiskInfo = $ui.FindName("TXT_TWEAK_DISK_INFO")
    if ($tweakDiskInfo) {
        $tweakDiskInfo.Text = "Drive C: ($diskType) - $dt GB Total ($($d.FileSystem))"
    }
    $tweakDiskUse = $ui.FindName("TXT_TWEAK_DISK_USE")
    if ($tweakDiskUse) {
        $pctUse = [math]::Round(($du / $dt) * 100, 0)
        $tweakDiskUse.Text = "$du GB Used ($pctUse%)"
    }
}

# GPU Identification (Prefer Dedicated)
$global:GpuVendorIsNvidia = $false
$global:GpuVendorIsAmd = $false
$global:GpuVendorIsIntel = $false
$gpus = Get-CimInstance Win32_VideoController | Sort-Object AdapterRAM -Descending
$dedicatedGPU = $gpus | Where-Object { $_.Name -match "NVIDIA|GeForce|RTX|GTX|Quadro|Radeon|AMD" -and $_.AdapterRAM -gt 1GB } | Select-Object -First 1
if (-not $dedicatedGPU) { $dedicatedGPU = $gpus | Select-Object -First 1 }

if ($dedicatedGPU) {
    $ui.FindName("TXT_GPU_NAME").Text = $dedicatedGPU.Name
    $ui.FindName("TXT_TWEAK_GPU_NAME_VAL").Text = $dedicatedGPU.Name
    $gpuNameList = $ui.FindName("TXT_TWEAK_GPU_NAME_VAL_LIST")
    if ($gpuNameList) { $gpuNameList.Text = $dedicatedGPU.Name }
    $vramGB = [math]::Round($dedicatedGPU.AdapterRAM / 1GB, 1)
    $ui.FindName("TXT_TWEAK_GPU_VRAM_VAL").Text = "$vramGB GB"
    $gpuVramList = $ui.FindName("TXT_TWEAK_GPU_VRAM_VAL_LIST")
    if ($gpuVramList) { $gpuVramList.Text = "$vramGB GB" }

    $ghz2 = $ui.FindName("TXT_GPU_HZ"); if ($ghz2 -and $dedicatedGPU.CurrentRefreshRate) { $ghz2.Text = "$($dedicatedGPU.CurrentRefreshRate) Hz" }

    $resLine = $dedicatedGPU.VideoModeDescription
    $gres2 = $ui.FindName("TXT_GPU_RES"); if ($gres2 -and $resLine) { $gres2.Text = $resLine }

    $vendorImg = $ui.FindName("IMG_GPU_VENDOR")
    $vendorImgList = $ui.FindName("IMG_GPU_VENDOR_LIST")
    if ($vendorImg) {
        if ($dedicatedGPU.Name -match "NVIDIA") { 
            $vendorImg.Source = $global:NvidiaIco 
            if ($vendorImgList) { $vendorImgList.Source = $global:NvidiaIco }
            $global:GpuVendorIsNvidia = $true
            $global:BgHash.IsNvidia = $true
        }
        elseif ($dedicatedGPU.Name -match "AMD|Radeon") { 
            $vendorImg.Source = $global:AmdIco
            if ($vendorImgList) { $vendorImgList.Source = $global:AmdIco }
            $global:GpuVendorIsAmd = $true
            $global:BgHash.IsAmdGpu = $true
        }
        elseif ($dedicatedGPU.Name -match "Intel") { 
            $vendorImg.Source = $global:IntelIco
            if ($vendorImgList) { $vendorImgList.Source = $global:IntelIco }
            $global:GpuVendorIsIntel = $true
            $global:BgHash.IsIntelGpu = $true
        }
        else {
            $vendorImg.Source = $global:GpuIco
            if ($vendorImgList) { $vendorImgList.Source = $global:GpuIco }
        }
    }
}

# Motherboard
$bd = Get-CimInstance Win32_BaseBoard -ErrorAction SilentlyContinue | Select-Object -First 1
if ($bd) {
    $mbName = $ui.FindName("TXT_MB_NAME"); if ($mbName) { $mbName.Text = "$($bd.Manufacturer)" }
    $mbProd = $ui.FindName("TXT_MB_PROD"); if ($mbProd) { $mbProd.Text = "$($bd.Product)" }
}
$bios = Get-CimInstance Win32_BIOS -ErrorAction SilentlyContinue | Select-Object -First 1
if ($bios) {
    $biosVer = $ui.FindName("TXT_BIOS_VER"); if ($biosVer) { $biosVer.Text = "BIOS Ver: $($bios.SMBIOSBIOSVersion)" }
}

# Initial RAM display
[HardwareEngine]::GetCpu() | Out-Null
$rp = [HardwareEngine]::GetRam()
$dRamPct = $ui.FindName("TXT_RAM")
if ($dRamPct) { $dRamPct.Text = "$rp" }
$waveRam = $ui.FindName("WAVE_FILL_RAM")
if ($waveRam) {
    $waveRam.Height = ($rp / 100.0) * 60
}

# Graph Initialization
$global:GraphMaxPoints = 60
$global:CpuHistory = [System.Collections.Generic.List[double]]::new()
$global:RamHistory = [System.Collections.Generic.List[double]]::new()
$global:GpuHistory = [System.Collections.Generic.List[double]]::new()

for ($i = 0; $i -lt $global:GraphMaxPoints; $i++) {
    $global:CpuHistory.Add(0)
    $global:RamHistory.Add(0)
    $global:GpuHistory.Add(0)
}

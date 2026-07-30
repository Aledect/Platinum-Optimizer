# Core Hardware Engine - C# Integration
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class HardwareEngine {
    [DllImport("srclient.dll", SetLastError=true)]
    public static extern int SRRemoveRestorePoint(uint dwRPNum);
    [DllImport("kernel32.dll", SetLastError=true)]
    static extern bool GetSystemTimes(out long idl, out long krn, out long usr);
    
    [StructLayout(LayoutKind.Sequential)]
    public struct MEMORYSTATUSEX {
        public uint dwLength; public uint dwMemoryLoad; public ulong ullTotalPhys;
        public ulong ullAvailPhys; public ulong ullTotalPageFile; public ulong ullAvailPageFile;
        public ulong ullTotalVirtual; public ulong ullAvailVirtual; public ulong ullAvailExtendedVirtual;
    }
    [DllImport("kernel32.dll", CharSet=CharSet.Auto, SetLastError=true)]
    static extern bool GlobalMemoryStatusEx(ref MEMORYSTATUSEX lpBuffer);

    static long oldIdl = 0; static long oldSys = 0;
    public static double GetCpu() {
        long idl, krn, usr;
        if(GetSystemTimes(out idl, out krn, out usr)) {
            long sys = krn + usr;
            if (oldSys != 0) {
                long sd = sys - oldSys; long id = idl - oldIdl;
                oldIdl = idl; oldSys = sys;
                if(sd > 0) return (double)(sd - id) * 100.0 / sd;
            }
            oldIdl = idl; oldSys = sys;
        } return 0;
    }
    public static double GetRam() {
        MEMORYSTATUSEX m = new MEMORYSTATUSEX();
        m.dwLength = (uint)Marshal.SizeOf(typeof(MEMORYSTATUSEX));
        if(GlobalMemoryStatusEx(ref m)) return m.dwMemoryLoad;
        return 0;
    }
}
"@

# Load LibreHardwareMonitor
try {
    $lhmPath = "$ModuleRoot\libs\LibreHardwareMonitor\LibreHardwareMonitorLib.dll"
    if (Test-Path $lhmPath) {
        Add-Type -Path $lhmPath
        $global:Computer = New-Object LibreHardwareMonitor.Hardware.Computer
        $global:Computer.IsCpuEnabled = $true
        $global:Computer.IsGpuEnabled = $true
        $global:Computer.IsMemoryEnabled = $true
        $global:Computer.IsStorageEnabled = $true
        $global:Computer.IsMotherboardEnabled = $true
        $global:Computer.Open()
    }
} catch {
    Write-Host "Failed to load LibreHardwareMonitor"
}
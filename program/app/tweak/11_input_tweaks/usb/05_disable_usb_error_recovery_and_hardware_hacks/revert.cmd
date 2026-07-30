@echo off
title By Platinum+ Optimizer

:: Restore Compatibility and Hardware Hacks from all existing device subkeys
for /f "delims=" %%K in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" 2^>nul') do (
    reg delete "%%K" /v AllowInvalidPipeHandles /f >nul 2>&1
    reg delete "%%K" /v DisableUASP /f >nul 2>&1
    reg delete "%%K" /v SkipSetIsochDelay /f >nul 2>&1
    reg delete "%%K" /v DisableHotReset /f >nul 2>&1
    reg delete "%%K" /v NonFunctional /f >nul 2>&1
    reg delete "%%K" /v DisableSuperSpeed /f >nul 2>&1
    reg delete "%%K" /v IncompatibleWithWindows /f >nul 2>&1
    reg delete "%%K" /v AddControllerSuffixedCompatIdToAudioDevices /f >nul 2>&1
    reg delete "%%K" /v AddMausbSuffixToHardwareId /f >nul 2>&1
    reg delete "%%K" /v EnablePLDRDuringCyclePort /f >nul 2>&1
    reg delete "%%K" /v ResetOnErrorInD2Resume /f >nul 2>&1
    reg delete "%%K" /v DisableRecoveryFromPowerDrain /f >nul 2>&1
)

echo Disable USB Error Recovery and Hardware Hacks restored successfully.

@echo off
title By Platinum+ Optimizer

:: Apply Compatibility and Hardware Hacks to all existing device subkeys
for /f "delims=" %%K in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" 2^>nul') do (
    reg add "%%K" /v AllowInvalidPipeHandles /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v DisableUASP /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v SkipSetIsochDelay /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v DisableHotReset /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v NonFunctional /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v DisableSuperSpeed /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v IncompatibleWithWindows /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v AddControllerSuffixedCompatIdToAudioDevices /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v AddMausbSuffixToHardwareId /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v EnablePLDRDuringCyclePort /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v ResetOnErrorInD2Resume /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v DisableRecoveryFromPowerDrain /t REG_DWORD /d 1 /f >nul 2>&1
)

echo Disable USB Error Recovery and Hardware Hacks applied successfully.

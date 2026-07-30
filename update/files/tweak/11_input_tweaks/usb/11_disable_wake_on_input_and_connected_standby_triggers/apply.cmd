@echo off
title By Platinum+ Optimizer

:: Disable Wake capabilities for all currently armed devices
for /f "tokens=*" %%A in ('powercfg /devicequery wake_armed 2^>nul') do (
    powercfg /devicedisablewake "%%A" >nul 2>&1
)

:: Apply Wake on Input Overrides to all enumerated Device Parameters
for /f "delims=" %%K in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "Device Parameters" /k 2^>nul ^| findstr /E "Device Parameters"') do (
    reg add "%%K" /v WakeSystemOnConnect /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v SystemWakeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v WaitWakeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v SuppressInputInCS /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v WakeScreenOnInputSupport /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v WakeScreenOnInputTimeout /t REG_DWORD /d 0 /f >nul 2>&1
)

:: Disable Global WakeOnInputDeviceTypes bitmask
reg add "HKLM\SYSTEM\INPUT" /v WakeOnInputDeviceTypes /t REG_DWORD /d 0 /f >nul 2>&1

echo Disable Wake on Input and Connected Standby Triggers applied successfully.

@echo off
title By Platinum+ Optimizer

:: Restore Wake on Input Overrides to all enumerated Device Parameters based on documented defaults
for /f "delims=" %%K in ('reg query "HKLM\SYSTEM\CurrentControlSet\Enum" /s /f "Device Parameters" /k 2^>nul ^| findstr /E "Device Parameters"') do (
    reg delete "%%K" /v WakeSystemOnConnect /f >nul 2>&1
    reg add "%%K" /v SystemWakeEnabled /t REG_DWORD /d 1 /f >nul 2>&1
    reg delete "%%K" /v WaitWakeEnabled /f >nul 2>&1
    reg add "%%K" /v SuppressInputInCS /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v WakeScreenOnInputSupport /t REG_DWORD /d 1 /f >nul 2>&1
    reg delete "%%K" /v WakeScreenOnInputTimeout /f >nul 2>&1
)

:: Restore Global WakeOnInputDeviceTypes bitmask
reg delete "HKLM\SYSTEM\INPUT" /v WakeOnInputDeviceTypes /f >nul 2>&1

echo Disable Wake on Input and Connected Standby Triggers restored successfully.

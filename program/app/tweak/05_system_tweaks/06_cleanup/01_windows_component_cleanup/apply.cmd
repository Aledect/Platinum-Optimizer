@echo off
title By Platinum+ Optimizer

net session >nul 2>&1 || exit /b 1

dism /Online /Cleanup-Image /StartComponentCleanup

for %%K in (
    "Temporary Files"
    "Temporary Setup Files"
    "Old ChkDsk Files"
    "Setup Log Files"
    "System error memory dump files"
    "System error minidump files"
    "Windows Error Reporting Archive Files"
    "Windows Error Reporting Queue Files"
    "Windows Error Reporting System Archive Files"
    "Windows Error Reporting System Queue Files"
    "Windows Upgrade Log Files"
    "Update Cleanup"
    "DirectX Shader Cache"
    "D3D Shader Cache"
    "Thumbnail"
    "Internet Cache Files"
    "Delivery Optimization Files"
) do (
    reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\%%~K" >nul 2>&1 && reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\%%~K" /v StateFlags0099 /t REG_DWORD /d 2 /f >nul 2>&1
)

if exist "%SystemRoot%\System32\cleanmgr.exe" start "" /wait "%SystemRoot%\System32\cleanmgr.exe" /sagerun:99

echo Done. Reboot recommended.

@echo off
title By Platinum+ Optimizer

:: Disable USB Telemetry, CEIP, and Diagnostic Subsystems
reg add "HKLM\SYSTEM\CurrentControlSet\Control\USBFN\Default" /v EnableDiagnostics /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Usb\Ceip" /v EnableCEIP /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\pnp" /v EnableDiagnostics /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\UsbLtm" /v EnableDiagnostics /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\devices" /v EnableDiagnostics /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\AutomaticSurpriseRemoval" /v EnableLogging /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\HardwareVerifier" /v EnableVerifier /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\Usb20HardwareLpm" /v EnableDiagnostics /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v EnableDiagnostics /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\USB" /v EnableDiagnostics /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\policy" /v EnableDiagnostics /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb" /v EnableDiagnostics /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl\LiveKernelReports" /v DisableUSBReports /t REG_DWORD /d 1 /f

echo Disable USB Telemetry and Diagnostic Subsystems applied successfully.

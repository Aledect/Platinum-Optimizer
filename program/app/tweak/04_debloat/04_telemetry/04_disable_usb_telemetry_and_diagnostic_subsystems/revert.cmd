@echo off
title By Platinum+ Optimizer

:: Restore USB Telemetry, CEIP, and Diagnostic Subsystems
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\USBFN\Default" /v EnableDiagnostics /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Usb\Ceip" /v EnableCEIP /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\pnp" /v EnableDiagnostics /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\UsbLtm" /v EnableDiagnostics /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\devices" /v EnableDiagnostics /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\AutomaticSurpriseRemoval" /v EnableLogging /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\HardwareVerifier" /v EnableVerifier /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\Usb20HardwareLpm" /v EnableDiagnostics /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v EnableDiagnostics /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\USB" /v EnableDiagnostics /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\policy" /v EnableDiagnostics /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb" /v EnableDiagnostics /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl\LiveKernelReports" /v DisableUSBReports /f >nul 2>&1

echo Disable USB Telemetry and Diagnostic Subsystems restored successfully.

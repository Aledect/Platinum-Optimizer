@echo off
title By Platinum+ Optimizer

:: Restore Power Management and Suspend State Optimizations
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\AutomaticSurpriseRemoval" /v AttemptRecoveryFromUsbPowerDrain /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\Usb20HardwareLpm" /v Usb20HardwareLpmOverride /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\Usb20HardwareLpm" /v Usb20HardwareLpmTimeout /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\UsbLtm" /v UsbLtmEnable /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v DisableSelectiveSuspend /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v ForceHcD3NoWakeArm /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v DisableCcDetect /f >nul 2>&1

:: Restore Host Controller Class-specific Power Overrides
for /f "delims=" %%K in ('reg query "HKLM\System\CurrentControlSet\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}" 2^>nul ^| findstr /R "[0-9][0-9][0-9][0-9]"') do (
    reg delete "%%K" /v HcDisableAllSelectiveSuspend /f >nul 2>&1
    reg delete "%%K" /v ForceHCResetOnResume /f >nul 2>&1
    reg delete "%%K" /v FastResumeEnable /f >nul 2>&1
)

echo Optimize Power Management and Suspend States restored successfully.

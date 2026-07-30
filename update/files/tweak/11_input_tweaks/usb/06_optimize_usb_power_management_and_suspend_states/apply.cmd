@echo off
title By Platinum+ Optimizer

:: Apply Power Management and Suspend State Optimizations
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\AutomaticSurpriseRemoval" /v AttemptRecoveryFromUsbPowerDrain /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\Usb20HardwareLpm" /v Usb20HardwareLpmOverride /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\Usb20HardwareLpm" /v Usb20HardwareLpmTimeout /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\UsbLtm" /v UsbLtmEnable /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v DisableSelectiveSuspend /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v ForceHcD3NoWakeArm /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v DisableCcDetect /t REG_DWORD /d 0 /f

:: Apply Host Controller Class-specific Power Overrides
for /f "delims=" %%K in ('reg query "HKLM\System\CurrentControlSet\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}" 2^>nul ^| findstr /R "[0-9][0-9][0-9][0-9]"') do (
    reg add "%%K" /v HcDisableAllSelectiveSuspend /t REG_DWORD /d 1 /f
    reg add "%%K" /v ForceHCResetOnResume /t REG_DWORD /d 0 /f
    reg add "%%K" /v FastResumeEnable /t REG_DWORD /d 1 /f
)

echo Optimize Power Management and Suspend States applied successfully.

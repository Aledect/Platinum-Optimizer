@echo off
title By Platinum+ Optimizer

:: Restore Power Management overrides from all existing device subkeys
for /f "delims=" %%K in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" 2^>nul') do (
    reg delete "%%K" /v DisableLpm /f >nul 2>&1
    reg delete "%%K" /v DisableUsb20HardwareLpm /f >nul 2>&1
    reg delete "%%K" /v DisableRemoteWakeForUsb20HardwareLpm /f >nul 2>&1
    reg delete "%%K" /v ResetOnResume /f >nul 2>&1
    reg delete "%%K" /v ResetOnResumeS0 /f >nul 2>&1
    reg delete "%%K" /v ResetOnResumeInSuperSpeed /f >nul 2>&1
    reg delete "%%K" /v DisableOnSoftRemove /f >nul 2>&1
    reg delete "%%K" /v PowerUpDelay /f >nul 2>&1
)

echo Disable USB Link Power Management and Sleep States restored successfully.

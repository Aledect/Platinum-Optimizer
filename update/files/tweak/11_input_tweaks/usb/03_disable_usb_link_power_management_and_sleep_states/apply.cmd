@echo off
title By Platinum+ Optimizer

:: Apply Power Management overrides to all existing device subkeys
for /f "delims=" %%K in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" 2^>nul') do (
    reg add "%%K" /v DisableLpm /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v DisableUsb20HardwareLpm /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v DisableRemoteWakeForUsb20HardwareLpm /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v ResetOnResume /t REG_BINARY /d 00000000 /f >nul 2>&1
    reg add "%%K" /v ResetOnResumeS0 /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v ResetOnResumeInSuperSpeed /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v DisableOnSoftRemove /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v PowerUpDelay /t REG_DWORD /d 0 /f >nul 2>&1
)

echo Disable USB Link Power Management and Sleep States applied successfully.

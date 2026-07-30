@echo off
title By Platinum+ Optimizer

:: Restore default 30-second timeouts (1E in hex) and D3 idle state (03 in hex) for Media devices
for /f "tokens=*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e96c-e325-11ce-bfc1-08002be10318}" ^| findstr /R "\\00[0-9][0-9]$"') do (
    reg add "%%a\PowerSettings" /v "ConservationIdleTime" /t REG_BINARY /d 1e000000 /f
    reg add "%%a\PowerSettings" /v "PerformanceIdleTime" /t REG_BINARY /d 00000000 /f
    reg add "%%a\PowerSettings" /v "CSConservationIdleTime" /t REG_BINARY /d 1e000000 /f
    reg add "%%a\PowerSettings" /v "CSPerformanceIdleTime" /t REG_BINARY /d 1e000000 /f
    reg add "%%a\PowerSettings" /v "IdlePowerState" /t REG_BINARY /d 03000000 /f
)

echo Restore USB Audio Idle Power Management applied successfully.

@echo off
title By Platinum+ Optimizer

:: Disable StorPort Power Management and Sleep States
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v DisableRuntimePower /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v HiberFileHybridPriority /t REG_BINARY /d 0000 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v StorageD3InModernStandby /t REG_DWORD /d 0 /f

echo Disable StorPort Power Management and Modern Standby applied successfully.

@echo off
title By Platinum+ Optimizer
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d 1500 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DeepIoCoalescingEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RITdemonTimerPowerSaveElapse" /t REG_DWORD /d 43200000 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RITdemonTimerPowerSaveCoalescing" /t REG_DWORD /d 43200000 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "InitTimerCoalescing" /t REG_BINARY /d 000000000000000000000000F5FFFF7FF5FFFF7FF5FFFF7FF5FFFF7F00000000000000000000000000000000F5FFFF7FF5FFFF7FF5FFFF7FF5FFFF7F00000000000000000000000000000000 /f
echo Disable Timer Coalescing for CPU Scheduling restored successfully.

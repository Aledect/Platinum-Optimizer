@echo off
title By Platinum+ Optimizer

reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdppm\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdppm\Parameters" /v "AcpiFirmwareWatchDog" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdppm\Parameters" /v "AmliWatchdogAction" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdppm\Parameters" /v "AmliWatchdogTimeout" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdppm\Parameters" /v "WatchdogTimeout" /t REG_DWORD /d "0" /f

echo enable AMD PPM Tweak applied successfully.

@echo off
title By Platinum+ Optimizer

reg delete "HKLM\SYSTEM\CurrentControlSet\Services\amdppm\Parameters" /v "DmaRemappingCompatible" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\amdppm\Parameters" /v "AcpiFirmwareWatchDog" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\amdppm\Parameters" /v "AmliWatchdogAction" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\amdppm\Parameters" /v "AmliWatchdogTimeout" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\amdppm\Parameters" /v "WatchdogTimeout" /f

echo restore AMD PPM Tweak applied successfully.

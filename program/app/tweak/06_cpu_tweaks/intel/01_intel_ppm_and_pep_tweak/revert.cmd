@echo off
title By Platinum+ Optimizer

reg delete "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "DmaRemappingCompatible" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "DmaRemappingCompatible" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\intelpep\Parameters" /v "ActiveAccountingIntervalInMs" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AcpiFirmwareWatchDog" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AmliWatchdogAction" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "AmliWatchdogTimeout" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\intelppm\Parameters" /v "WatchdogTimeout" /f

echo restore Intel PPM / PEP Tweak applied successfully.

@echo off
title By Platinum+ Optimizer
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "SerializeTimerExpiration" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "EnablePerCpuClockTickScheduling" /f
bcdedit /deletevalue disabledynamictick
echo Restore Timer Serialization and Optimize Clock Tick Scheduling applied successfully.

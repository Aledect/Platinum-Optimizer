@echo off
title By Platinum+ Optimizer
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "SerializeTimerExpiration" /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "EnablePerCpuClockTickScheduling" /t REG_DWORD /d 1 /f
bcdedit /set disabledynamictick yes
echo Disable Timer Serialization and Optimize Clock Tick Scheduling applied successfully.

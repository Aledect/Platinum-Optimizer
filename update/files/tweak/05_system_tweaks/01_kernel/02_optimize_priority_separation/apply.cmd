@echo off
title By Platinum+ Optimizer
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "ForceForegroundBoostDecay" /t REG_DWORD /d 0 /f
echo Optimize Win32PrioritySeparation and Foreground Boost Decay applied successfully.

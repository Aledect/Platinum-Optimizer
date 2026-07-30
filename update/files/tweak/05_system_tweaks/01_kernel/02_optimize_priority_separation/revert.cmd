@echo off
title By Platinum+ Optimizer
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 2 /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "ForceForegroundBoostDecay" /f
echo Restore Win32PrioritySeparation and Foreground Boost Decay applied successfully.

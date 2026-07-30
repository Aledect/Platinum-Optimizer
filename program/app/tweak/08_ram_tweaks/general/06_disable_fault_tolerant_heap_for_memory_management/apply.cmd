@echo off
title By Platinum+ Optimizer
reg add "HKLM\Software\Microsoft\FTH" /v Enabled /t REG_DWORD /d 0 /f
echo Disable Fault-Tolerant Heap applied successfully.

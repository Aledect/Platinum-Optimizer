@echo off
title By Platinum+ Optimizer
reg add "HKLM\Software\Microsoft\FTH" /v Enabled /t REG_DWORD /d 1 /f
echo Restore Fault-Tolerant Heap applied successfully.

@echo off
title By Platinum+ Optimizer
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x1194f158" /t REG_DWORD /d 1 /f
echo Optimize Variable Refresh Rate (VRR) for GPU - Restored Successfully

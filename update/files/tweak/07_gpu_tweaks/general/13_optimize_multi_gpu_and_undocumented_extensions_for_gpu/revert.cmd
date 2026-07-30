@echo off
title By Platinum+ Optimizer
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11fbdf11" /t REG_DWORD /d 0 /f
reg delete "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11c776e0" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x01abac23" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11301a5a" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11424d6a" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x117cd1d5" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x118ad143" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x1191e8ab" /f >nul 2>&1
echo Optimize Multi-GPU and Undocumented Extensions for GPU - Restored Successfully

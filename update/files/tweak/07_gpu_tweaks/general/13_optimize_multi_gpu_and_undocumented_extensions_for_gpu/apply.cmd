@echo off
title By Platinum+ Optimizer
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11fbdf11" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11c776e0" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x01abac23" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11301a5a" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11424d6a" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x117cd1d5" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x118ad143" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x1191e8ab" /t REG_DWORD /d 0 /f
echo Optimize Multi-GPU and Undocumented Extensions for GPU - Applied Successfully

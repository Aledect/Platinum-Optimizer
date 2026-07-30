@echo off
title By Platinum+ Optimizer
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x112493bd" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11333333" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11aa9e99" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11ae435c" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11d9dc84" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11e91a61" /t REG_DWORD /d 0 /f
echo Disable Workstation and Stereo 3D Features for GPU - Applied Successfully

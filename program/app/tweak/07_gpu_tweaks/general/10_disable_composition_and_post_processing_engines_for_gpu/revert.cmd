@echo off
title By Platinum+ Optimizer
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11112255" /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\nvlddmkm\State" /v "0x11112256" /t REG_DWORD /d 51 /f
echo Disable Composition and Post-Processing Engines for GPU - Restored Successfully

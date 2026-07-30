@echo off
title By Platinum+ Optimizer

reg add "HKLM\SYSTEM\ControlSet001\Services\msisadrv\Parameters" /v "DmaRemappingCompatible" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Enum\pci\VEN_1022&DEV_1483&SUBSYS_88081043&REV_00\Parameters\DMA Management" /v "RemappingSupported" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Enum\pci\VEN_1022&DEV_1483&SUBSYS_88081043&REV_00\Parameters\DMA Management" /v "RemappingFlags" /t REG_DWORD /d 0 /f

echo Disable DMA Remapping for PCIe Components applied successfully.

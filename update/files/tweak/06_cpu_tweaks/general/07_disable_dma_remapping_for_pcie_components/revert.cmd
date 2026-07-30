@echo off
title By Platinum+ Optimizer

reg delete "HKLM\SYSTEM\ControlSet001\Services\msisadrv\Parameters" /v "DmaRemappingCompatible" /f
reg delete "HKLM\SYSTEM\ControlSet001\Enum\pci\VEN_1022&DEV_1483&SUBSYS_88081043&REV_00\Parameters\DMA Management" /v "RemappingSupported" /f
reg delete "HKLM\SYSTEM\ControlSet001\Enum\pci\VEN_1022&DEV_1483&SUBSYS_88081043&REV_00\Parameters\DMA Management" /v "RemappingFlags" /f

echo Disable DMA Remapping for PCIe Components restored successfully.

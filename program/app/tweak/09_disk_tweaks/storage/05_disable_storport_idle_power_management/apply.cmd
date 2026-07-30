@echo off
title By Platinum+ Optimizer

set "BASE=HKLM\SYSTEM\CurrentControlSet\Enum\Target_Enumerator\Target_DeviceID\Target_InstanceID\Device Parameters"

:: StorPort Parameters
reg add "%BASE%\StorPort" /v "DlrmDisable" /t REG_DWORD /d 1 /f
reg add "%BASE%\StorPort" /v "EnableNVMeInterface" /t REG_DWORD /d 1 /f
reg add "%BASE%\StorPort" /v "FwActivateTimeoutForController" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "TotalSenseDataBytes" /t REG_DWORD /d 256 /f
reg add "%BASE%\StorPort" /v "AdapterGuid" /t REG_BINARY /d 00 /f
reg add "%BASE%\StorPort" /v "BusSpecificResetTimeout" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "DisableD3Cold" /t REG_DWORD /d 1 /f
reg add "%BASE%\StorPort" /v "DisableNVMeActiveNamespaceIDListCheck" /t REG_DWORD /d 1 /f
reg add "%BASE%\StorPort" /v "DisableRuntimePowerManagement" /t REG_DWORD /d 1 /f
reg add "%BASE%\StorPort" /v "EnableIdlePowerManagement" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "GeneratedID" /t REG_BINARY /d 00 /f
reg add "%BASE%\StorPort" /v "IdleTimeoutInMS" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "InitialTimestamp" /t REG_QWORD /d 0 /f
reg add "%BASE%\StorPort" /v "Is1667Device" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "PLDRTimeout" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "PowerCycleCount" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "PowerCycleCountOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "PowerSrbTimeout" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "UseDMAv3" /t REG_DWORD /d 1 /f
reg add "%BASE%\StorPort" /v "BusyPauseTime" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "BusyRetryCount" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "DisableIdlePowerManagement" /t REG_DWORD /d 1 /f
reg add "%BASE%\StorPort" /v "EnableLogoETW" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "MinimumIdleTimeoutInMS" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "QueueFullWaitIoPercentage" /t REG_DWORD /d 100 /f

:: DMA Management
reg add "%BASE%\DMA Management" /v "RemappingFlags" /t REG_DWORD /d 0 /f
reg add "%BASE%\DMA Management" /v "RemappingSupported" /t REG_DWORD /d 0 /f

:: Partmgr
reg add "%BASE%\partmgr" /v "Attributes" /t REG_DWORD /d 0 /f
reg add "%BASE%\partmgr" /v "DiskId" /t REG_SZ /d "" /f

:: WUDF
reg add "%BASE%\WUDF" /v "SoftwareDeviceTag" /t REG_DWORD /d 0 /f
reg add "%BASE%\WUDF\CompanionConfigurations\USBXHCI" /v "CompanionServiceList" /t REG_SZ /d "" /f

:: Disk
reg add "%BASE%\Disk" /v "UserWriteCacheSetting" /t REG_DWORD /d 1 /f

echo Disable StorPort Idle Power Management applied successfully.

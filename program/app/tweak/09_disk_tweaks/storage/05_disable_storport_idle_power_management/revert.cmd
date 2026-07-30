@echo off
title By Platinum+ Optimizer

set "BASE=HKLM\SYSTEM\CurrentControlSet\Enum\Target_Enumerator\Target_DeviceID\Target_InstanceID\Device Parameters"

reg add "%BASE%\StorPort" /v "BusSpecificResetTimeout" /t REG_DWORD /d 5 /f
reg add "%BASE%\StorPort" /v "DisableD3Cold" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "DisableNVMeActiveNamespaceIDListCheck" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "DisableRuntimePowerManagement" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "EnableIdlePowerManagement" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "IdleTimeoutInMS" /t REG_DWORD /d 60000 /f
reg add "%BASE%\StorPort" /v "Is1667Device" /t REG_DWORD /d 4294967295 /f
reg add "%BASE%\StorPort" /v "PLDRTimeout" /t REG_DWORD /d 10 /f
reg add "%BASE%\StorPort" /v "TotalSenseDataBytes" /t REG_DWORD /d 256 /f
reg add "%BASE%\StorPort" /v "UseDMAv3" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "BusyPauseTime" /t REG_DWORD /d 250 /f
reg add "%BASE%\StorPort" /v "BusyRetryCount" /t REG_DWORD /d 20 /f
reg add "%BASE%\StorPort" /v "DisableIdlePowerManagement" /t REG_DWORD /d 0 /f
reg add "%BASE%\StorPort" /v "MinimumIdleTimeoutInMS" /t REG_DWORD /d 4294967295 /f
reg add "%BASE%\StorPort" /v "QueueFullWaitIoPercentage" /t REG_DWORD /d 25 /f

echo Disable StorPort Idle Power Management restored successfully.

@echo off
title By Platinum+ Optimizer

:: Optimize StorPort I/O Queues and Hardware Processing
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v DpcCompletionLimit /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v HmbAllocationPolicy /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v HmbMaximumSizeInBytes /t REG_DWORD /d 67108864 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v MiniportBugActionPolicy /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v AsyncStart /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v ExtendedDSMCommandsSupported /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v FUAEnable /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v QoSFlags /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v MaxPreAllocatedIoResourceCount /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v DFxEnable /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v OverrideDeviceUniqueIDCapability /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v ProcsPerGateway /t REG_DWORD /d 16 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v MFNDEnable /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v CreateControlObject /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v DisableIEEE1667 /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v EnableNativeTcg /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v DeviceQueueIoWaitThreshold /t REG_QWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v HighLatencyIoThreshold /t REG_QWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v ReportAllWheaErrorsAsNonFatal /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v DisableExtensionDriver /t REG_DWORD /d 1 /f

echo Optimize StorPort I/O Queues, DPC, and Hardware Processing applied successfully.

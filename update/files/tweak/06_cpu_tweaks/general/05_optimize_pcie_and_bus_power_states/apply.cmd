@echo off
title By Platinum+ Optimizer

set "BASE=HKLM\SYSTEM\CurrentControlSet\Enum\Target_Enumerator\Target_DeviceID\Target_InstanceID\Device Parameters"

:: PCI / Bus Parameters
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "BusDataLinkSettleTime" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "D3ColdSupported" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "DeviceD0DelayTime" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "DeviceDpcCleanUpActionOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "DeviceDpcResetActionOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "DevicePowerResetDelayTime" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "ForceSBR" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "IgnoreErrorsDuringPLDR" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "IoNotRequired" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "RecoveryDisabled" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "RecoveryEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "SettleTimeRequired" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "SriovSupported" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "ASPMOptOut" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "ASPMOptIn" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "AtomicsOptIn" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "BridgeUseNativeWakeInfo" /t REG_DWORD /d 0 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "EnableAllBridgeInterrupts" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "DoNotUseAcs" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "AcsNotRequired" /t REG_DWORD /d 1 /f

:: CEIP / SQM Flags
reg add "%BASE%\Ceip" /v "DeviceInformation" /t REG_DWORD /d 0 /f
reg add "%BASE%\Ceip" /v "PortInterconnectType" /t REG_DWORD /d 0 /f
reg add "%BASE%\Ceip" /v "DescriptorValidationInfo0" /t REG_DWORD /d 0 /f
reg add "%BASE%\Ceip" /v "DescriptorValidationInfo1" /t REG_DWORD /d 0 /f
reg add "%BASE%\Ceip" /v "DescriptorValidationInfo2" /t REG_DWORD /d 0 /f
reg add "%BASE%\Ceip" /v "DescriptorValidationInfo3" /t REG_DWORD /d 0 /f
reg add "%BASE%\Ceip" /v "DescriptorValidationInfo4" /t REG_DWORD /d 0 /f
reg add "%BASE%\Ceip" /v "DescriptorValidationInfo5" /t REG_DWORD /d 0 /f
reg add "%BASE%\Ceip" /v "DescriptorValidationInfo6" /t REG_DWORD /d 0 /f

:: WDF Power Parameters
reg add "%BASE%\Wdf" /v "IdleInWorkingState" /t REG_DWORD /d 0 /f
reg add "%BASE%\Wdf" /v "WakeFromSleepState" /t REG_DWORD /d 0 /f
reg add "%BASE%\Wdf" /v "WdfDefaultIdleInWorkingState" /t REG_DWORD /d 0 /f
reg add "%BASE%\Wdf" /v "WdfDirectedPowerTransitionChildrenOptional" /t REG_DWORD /d 0 /f
reg add "%BASE%\Wdf" /v "WdfDirectedPowerTransitionEnable" /t REG_DWORD /d 0 /f
reg add "%BASE%\Wdf" /v "WdfUseWdfTimerForPofx" /t REG_DWORD /d 0 /f
reg add "%BASE%\Wdf" /v "SleepstudyState" /t REG_DWORD /d 0 /f
reg add "%BASE%\Wdf" /v "WdfDefaultWakeFromSleepState" /t REG_DWORD /d 0 /f

echo Optimize PCIe and Bus Power States applied successfully.

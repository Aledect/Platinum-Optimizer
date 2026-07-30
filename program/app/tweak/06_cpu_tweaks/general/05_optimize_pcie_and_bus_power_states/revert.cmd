@echo off
title By Platinum+ Optimizer

set "BASE=HKLM\SYSTEM\CurrentControlSet\Enum\Target_Enumerator\Target_DeviceID\Target_InstanceID\Device Parameters"

reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "D3ColdSupported" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "DeviceD0DelayTime" /t REG_DWORD /d 100 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "ForceSBR" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "IgnoreErrorsDuringPLDR" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "IoNotRequired" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "RecoveryDisabled" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "RecoveryEnabled" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "SettleTimeRequired" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "SriovSupported" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "AtomicsOptIn" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "BridgeUseNativeWakeInfo" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "EnableAllBridgeInterrupts" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "DoNotUseAcs" /t REG_DWORD /d 1 /f
reg add "%BASE%\e5b3b5ac-9725-4f78-963f-03dfb1d828c7" /v "AcsNotRequired" /t REG_DWORD /d 1 /f

reg add "%BASE%\Wdf" /v "WdfDirectedPowerTransitionChildrenOptional" /t REG_DWORD /d 1 /f
reg add "%BASE%\Wdf" /v "WdfDirectedPowerTransitionEnable" /t REG_DWORD /d 1 /f

echo Optimize PCIe and Bus Power States restored successfully.

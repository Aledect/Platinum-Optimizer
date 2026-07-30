@echo off
title By Platinum+ Optimizer

set "BASE=HKLM\SYSTEM\CurrentControlSet\Enum\Target_Enumerator\Target_DeviceID\Target_InstanceID\Device Parameters"

:: Interrupt Management
reg add "%BASE%\Interrupt Management\MessageSignaledInterruptProperties" /v "MessageNumberLimit" /t REG_DWORD /d 0 /f
reg add "%BASE%\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d 1 /f
reg add "%BASE%\Interrupt Management\MessageSignaledInterruptProperties\Range\0" /v "StartingMessage" /t REG_DWORD /d 0 /f
reg add "%BASE%\Interrupt Management\MessageSignaledInterruptProperties\Range\0" /v "EndingMessage" /t REG_DWORD /d 0 /f
reg add "%BASE%\Interrupt Management\MessageSignaledInterruptProperties\Range\0" /v "MessagesPerProcessor" /t REG_DWORD /d 0 /f

:: Affinity Policy
reg add "%BASE%\Interrupt Management\Affinity Policy" /v "AssignmentSetOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%\Interrupt Management\Affinity Policy" /v "DevicePolicy" /t REG_DWORD /d 0 /f
reg add "%BASE%\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d 0 /f
reg add "%BASE%\Interrupt Management\Affinity Policy" /v "GroupOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%\Interrupt Management\Affinity Policy" /v "GroupPolicy" /t REG_DWORD /d 0 /f
reg add "%BASE%\Interrupt Management\Affinity Policy - Temporal" /v "TargetGroup" /t REG_DWORD /d 0 /f
reg add "%BASE%\Interrupt Management\Affinity Policy - Temporal" /v "TargetSet" /t REG_QWORD /d 0 /f

:: Routing Info
reg add "%BASE%\Interrupt Management\Routing Info" /v "Flags" /t REG_DWORD /d 0 /f
reg add "%BASE%\Interrupt Management\Routing Info" /v "LinkNode" /t REG_BINARY /d 00 /f
reg add "%BASE%\Interrupt Management\Routing Info" /v "StaticVector" /t REG_DWORD /d 0 /f

:: Miscellaneous Values
set "MISC=HKLM\SYSTEM\CurrentControlSet\Enum\Target_Enumerator\Target_DeviceID\Target_InstanceID"
reg add "%MISC%" /v "Address" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "Capabilities" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "CompatibleIDs" /t REG_MULTI_SZ /d "" /f
reg add "%MISC%" /v "ConfigFlags" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "ContainerID" /t REG_SZ /d "" /f
reg add "%MISC%" /v "DeviceCharacteristics" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "DeviceDesc" /t REG_SZ /d "" /f
reg add "%MISC%" /v "DeviceReported" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "DeviceType" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "Driver" /t REG_SZ /d "" /f
reg add "%MISC%" /v "Exclusive" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "HardwareID" /t REG_MULTI_SZ /d "" /f
reg add "%MISC%" /v "InstallFlags" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "LocationInformation" /t REG_SZ /d "" /f
reg add "%MISC%" /v "LowerFilters" /t REG_MULTI_SZ /d "" /f
reg add "%MISC%" /v "Mfg" /t REG_SZ /d "" /f
reg add "%MISC%" /v "ParentIdPrefix" /t REG_SZ /d "" /f
reg add "%MISC%" /v "Phantom" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "RemovalPolicy" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "SECURITY" /t REG_SZ /d "" /f
reg add "%MISC%" /v "Service" /t REG_SZ /d "" /f
reg add "%MISC%" /v "UINumber" /t REG_DWORD /d 0 /f
reg add "%MISC%" /v "UINumberDescFormat" /t REG_SZ /d "" /f
reg add "%MISC%" /v "UniqueParentID" /t REG_SZ /d "" /f
reg add "%MISC%" /v "UpperFilters" /t REG_MULTI_SZ /d "" /f
reg add "%MISC%\Control" /v "AllocConfig" /t REG_DWORD /d 0 /f
reg add "%MISC%\LogConf" /v "AllocConfig" /t REG_DWORD /d 0 /f
reg add "%MISC%\LogConf" /v "BootConfig" /t REG_DWORD /d 0 /f
reg add "%MISC%\LogConf" /v "ForcedConfig" /t REG_DWORD /d 0 /f
reg add "%MISC%\LogConf" /v "OverrideConfigVector" /t REG_DWORD /d 0 /f

:: BiosConfig
reg add "%BASE%\BiosConfig" /v "DEV_00&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_00&FUN_01" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_00&FUN_02" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_00&FUN_03" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_01&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_01&FUN_01" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_01&FUN_02" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_02&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_03&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_03&FUN_01" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_04&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_05&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_07&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_07&FUN_01" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_08&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_08&FUN_01" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_09&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_14&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_14&FUN_03" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_18&FUN_00" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_18&FUN_01" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_18&FUN_02" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_18&FUN_03" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_18&FUN_04" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_18&FUN_05" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_18&FUN_06" /t REG_DWORD /d 0 /f
reg add "%BASE%\BiosConfig" /v "DEV_18&FUN_07" /t REG_DWORD /d 0 /f

echo Optimize Interrupt Management and Affinity Policy applied successfully.

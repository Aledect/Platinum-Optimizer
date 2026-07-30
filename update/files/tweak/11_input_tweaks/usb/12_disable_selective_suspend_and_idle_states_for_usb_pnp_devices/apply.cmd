@echo off
title By Platinum+ Optimizer

:: Apply explicit WMI overrides for USB devices as documented
reg add "HKLM\System\CurrentControlSet\Enum\USB\ROOT_HUB30\5&2c35141&0&0\Device Parameters\WDF" /v "IdleInWorkingState" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\ROOT_HUB30\5&2bce96aa&0&0\Device Parameters\WDF" /v "IdleInWorkingState" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_046D&PID_0ABA&MI_03\7&41505d0&0&0003\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_05E3&PID_0610\6&3365fbaf&0&11\Device Parameters\WDF" /v "IdleInWorkingState" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_0B05&PID_1939&MI_02\7&40fe908&0&0002\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_046D&PID_C547&MI_00\7&1fc2034b&0&0000\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_046D&PID_C547&MI_01\7&1fc2034b&0&0001\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_046D&PID_C547&MI_02\7&1fc2034b&0&0002\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_1038&PID_161E&MI_00\7&a6e656e&0&0000\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_1038&PID_161E&MI_01\7&a6e656e&0&0001\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_1038&PID_161E&MI_02\7&a6e656e&0&0002\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_1038&PID_161E&MI_03\7&a6e656e&0&0003\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_1038&PID_161E&MI_04\7&a6e656e&0&0004\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_0CF2&PID_A102&MI_01\8&7b0cf2a&0&0001\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0000" /v "PnPCapabilities" /t REG_DWORD /d 24 /f

:: Apply all generalized PnP Device Parameters to a target placeholder path to ensure 100% coverage without corrupting dynamic hardware IDs
set "BASE=HKLM\SYSTEM\CurrentControlSet\Enum\Target_Enumerator\Target_DeviceID\Target_InstanceID\Device Parameters"
reg add "%BASE%" /v "AllowIdleIrpInD3" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "CollectionReenumerateSelfInterfaceEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "ComboHardwareIdV2Enabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "CyclePortEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "D3ColdReconnectTimeout" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DefaultIdleState" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DefaultIdleTimeout" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DeviceIdleEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DeviceIdleIgnoreWakeEnable" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DeviceInterfaceGUID" /t REG_SZ /d "" /f
reg add "%BASE%" /v "DeviceInterfaceGUIDs" /t REG_MULTI_SZ /d "" /f
reg add "%BASE%" /v "DevicePowerUpOnS0Entry" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "DeviceResetNotificationEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DeviceSelectiveSuspended" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "EndpointPriorities" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "EnhancedPowerManagementEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "EnhancedPowerManagementUseMonitor" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "ExtPropDescSemaphore" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "ForceSelectiveSuspend" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "FriendlyName" /t REG_SZ /d "" /f
reg add "%BASE%" /v "LegacyTouchScaling" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "RemoteWakeEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "ResetPortEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "RetainWWIrpWhenDeviceAbsent" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "RevisionId" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "SelectiveSuspendEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "SelectiveSuspendOn" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "SelectiveSuspendSupported" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "SelectiveSuspendTimeout" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "SelSuspCancelBehavior" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "SessionSecurityEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "SuppressInputInCS" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "SystemInputSuppressionEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "SystemWakeEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "TestIdleMonitorDim" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "TestIdleTimeoutNoHandles" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "TestIdleTimeoutNoHandlesInitial" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "UserSetDeviceIdleEnabled" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "VendorRevision" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "WakeScreenOnInputSupport" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "WakeScreenOnInputTimeout" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "WinRtInterfaceRestrictionLevel" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "WinusbIsochUsed" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "WinUsbPowerPolicyOwnershipDisabled" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "WriteReportExSupported" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "AOCID" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "AutoplayOnSpecialInterface" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "CustomWake" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DefaultSimulatedTarget" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DeviceDumpVendorGPLogAddress" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DeviceGroup" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DeviceGroups" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "DeviceHandlers" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "FailReasonID" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "FirmwareCapsuleFilename" /t REG_SZ /d "" /f
reg add "%BASE%" /v "FirmwareFilename" /t REG_SZ /d "" /f
reg add "%BASE%" /v "FirmwareId" /t REG_SZ /d "" /f
reg add "%BASE%" /v "FirmwareIntegrityFilename" /t REG_SZ /d "" /f
reg add "%BASE%" /v "FirmwareMeasurementsFilename" /t REG_SZ /d "" /f
reg add "%BASE%" /v "FirmwareStatus" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "FirmwareVersion" /t REG_SZ /d "" /f
reg add "%BASE%" /v "FirmwareVersionFormat" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "FlipFlopHScroll" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "FlipFlopWheel" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "ForceVirtualDesktop" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "FullPowerDownOnTransientDx" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "FunctionDriverOptIn" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "HackFlags" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "HardResetCount" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "HasPhysicalKeys" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "HScrollHighResolutionDisable" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "HScrollPageOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "HScrollScalingFactor" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "HScrollUsageOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "HubFWUpdateProtocol" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "Icons" /t REG_SZ /d "" /f
reg add "%BASE%" /v "IdleSupported" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "IdleTimeoutPeriodInMilliSec" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "KeyboardNumberFunctionKeysOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "KeyboardNumberIndicatorsOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "KeyboardNumberTotalKeysOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "KeyboardSubtypeOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "KeyboardTypeOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "Label" /t REG_SZ /d "" /f
reg add "%BASE%" /v "NoMediaIcons" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "NoSoftEject" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "NumberOfPairingSlots" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "OriginalConfigurationValue" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "OvercurrentDetected" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "RootBus" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "TargetForcePriorityList" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "TargetPriorityList" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "Usb4HostName" /t REG_SZ /d "" /f
reg add "%BASE%" /v "UsbccgpCapabilities" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "UseStrictBiosHandoff" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "VhfMode" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "VideoID" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "VScrollHighResolutionDisable" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "VScrollPageOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "VScrollUsageOverride" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "WakeSystemOnConnect" /t REG_DWORD /d 0 /f
reg add "%BASE%" /v "WheelScalingFactor" /t REG_DWORD /d 0 /f

echo Disable Selective Suspend and Idle States applied successfully.

@echo off
title By Platinum+ Optimizer

:: Restore explicit WMI overrides for USB devices
reg add "HKLM\System\CurrentControlSet\Enum\USB\ROOT_HUB30\5&2c35141&0&0\Device Parameters\WDF" /v "IdleInWorkingState" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\ROOT_HUB30\5&2bce96aa&0&0\Device Parameters\WDF" /v "IdleInWorkingState" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_046D&PID_0ABA&MI_03\7&41505d0&0&0003\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_05E3&PID_0610\6&3365fbaf&0&11\Device Parameters\WDF" /v "IdleInWorkingState" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_0B05&PID_1939&MI_02\7&40fe908&0&0002\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_046D&PID_C547&MI_00\7&1fc2034b&0&0000\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_046D&PID_C547&MI_01\7&1fc2034b&0&0001\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_046D&PID_C547&MI_02\7&1fc2034b&0&0002\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_1038&PID_161E&MI_00\7&a6e656e&0&0000\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_1038&PID_161E&MI_01\7&a6e656e&0&0001\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_1038&PID_161E&MI_02\7&a6e656e&0&0002\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_1038&PID_161E&MI_03\7&a6e656e&0&0003\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_1038&PID_161E&MI_04\7&a6e656e&0&0004\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Enum\USB\VID_0CF2&PID_A102&MI_01\8&7b0cf2a&0&0001\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0000" /v "PnPCapabilities" /t REG_DWORD /d 16 /f

:: Restore placeholder path
set "BASE=HKLM\SYSTEM\CurrentControlSet\Enum\Target_Enumerator\Target_DeviceID\Target_InstanceID\Device Parameters"
reg add "%BASE%" /v "AllowIdleIrpInD3" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "DefaultIdleState" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "DefaultIdleTimeout" /t REG_DWORD /d 5000 /f
reg add "%BASE%" /v "DeviceIdleEnabled" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "DeviceIdleIgnoreWakeEnable" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "DevicePowerUpOnS0Entry" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "DeviceResetNotificationEnabled" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "EnhancedPowerManagementEnabled" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "ExtPropDescSemaphore" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "SelectiveSuspendOn" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "SelectiveSuspendTimeout" /t REG_DWORD /d 5000 /f
reg add "%BASE%" /v "SystemInputSuppressionEnabled" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "SystemWakeEnabled" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "TestIdleMonitorDim" /t REG_DWORD /d 1000 /f
reg add "%BASE%" /v "TestIdleTimeoutNoHandles" /t REG_DWORD /d 1000 /f
reg add "%BASE%" /v "TestIdleTimeoutNoHandlesInitial" /t REG_DWORD /d 5000 /f
reg add "%BASE%" /v "UserSetDeviceIdleEnabled" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "WakeScreenOnInputSupport" /t REG_DWORD /d 1 /f
reg add "%BASE%" /v "WinRtInterfaceRestrictionLevel" /t REG_DWORD /d 255 /f

echo Restore Selective Suspend and Idle States applied successfully.

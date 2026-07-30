@echo off
title By Platinum+ Optimizer
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "AlpcMessageLog" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "AlpcWakePolicy" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CriticalSectionTimeout" /t REG_DWORD /d 2592000 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CWDIllegalInDLLSearch" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "Debugger Retries" /t REG_DWORD /d 20 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "DebuggerMaxModuleMsgs" /t REG_DWORD /d 500 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "DisableIFEOCaching" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ErrorPortCommTimeout" /t REG_DWORD /d 10000 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ErrorPortStartTimeout" /t REG_DWORD /d 15000 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "GlobalFlag" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "GlobalFlag2" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapSegmentReserve" /t REG_DWORD /d 1048576 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapSegmentCommit" /t REG_DWORD /d 8192 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapDeCommitFreeBlockThreshold" /t REG_DWORD /d 4096 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "HeapDeCommitTotalFreeThreshold" /t REG_DWORD /d 65536 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ImageExecutionOptions" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "InitConsoleFlags" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "MultiUsersInSessionSupported" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ObjectSecurityMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "PowerSimulateHiberBugcheck" /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "PowerPolicySimulate" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ResourceCheckFlags" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ResourceEnforceOwnerTransfer" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ResourceTimeoutCount" /t REG_DWORD /d 45 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "SkipRegistryInit" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Quota System" /v "ApplicationBlockedMessageLimit" /t REG_DWORD /d 50 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Quota System" /v "JobTimeLimitsPeriodSeconds" /t REG_DWORD /d 7 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Quota System" /v "SystemBlockedMessageLimit" /t REG_DWORD /d 200 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Throttle" /v "PerfEnablePackageIdle" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Segment Heap" /v "Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\LSA" /v "AuditBaseDirectories" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\LSA" /v "AuditBaseObjects" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\LSA\audit" /v "ProcessAccessesToAudit" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /v "ActiveTimeBias" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /v "Bias" /t REG_DWORD /d 480 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /v "RealTimeIsUniversal" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions" /v "ProductSuite" /t REG_SZ /d "" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions" /v "CmSuiteBuffer" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions" /v "CmSuiteBufferLength" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions" /v "CmSuiteBufferType" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel\RNG" /v "RNGAuxiliarySeed" /t REG_DWORD /d 0 /f
echo Optimize General Session Manager and Miscellaneous Control Parameters applied successfully.

@echo off
title By Platinum+ Optimizer

:: Disable Hardware Workarounds and Compatibility Layers
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ContiguousMemoryFromAnyNode /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ShutdownTimeout /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DeallocateMaxLbaCount /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DisableDeallocate /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ControllerBasicInit /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v AsyncEventMask /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IoStripeAlignment /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v HostMemoryBufferBytes /t REG_MULTI_SZ /d "4294967295" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v BypassSgl /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ResetEnableMask /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ForcedPhysicalSectorSizeInBytes /t REG_MULTI_SZ /d "4096" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v RetainAsyncEventControlMask /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ShutdownTimeoutForSurpriseRemove /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DisableMFNDCCDuringRemoval /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DisableNamespacePreferredValueCheck /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IgnoreNamespacePreferredValues /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DisableGetActiveNSIDList /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ForceCryptoEraseToUseFormatNVM /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ControllerResetWaitTimeCushion /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DisableActivateFWWithoutReset /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DisableDSTThrottle /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DisableF0TimestampSync /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DisableForwardedIO /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v EnableIntelTSESplitIOWorkaround /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v EnforceActiveNamespaceIdentification /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v SupportZeroActiveNamespace /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v WeightedRoundRobinEnabled /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v HostIdentifier /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v LinkTimeout /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MaximumLogicalUnit /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MaximumUCXAddress /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MinimumUCXAddress /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v UncachedExtAlignment /t REG_MULTI_SZ /d "0" /f

echo Disable NVMe Hardware Workarounds and Compatibility Layers applied successfully.

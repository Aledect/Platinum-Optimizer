@echo off
title By Platinum+ Optimizer

:: Restore Descriptor and Enumeration overrides from all existing device subkeys
for /f "delims=" %%K in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" 2^>nul') do (
    reg delete "%%K" /v IgnoreHWSerNum /f >nul 2>&1
    reg delete "%%K" /v UseWin8DescriptorValidation /f >nul 2>&1
    reg delete "%%K" /v osvc /f >nul 2>&1
    reg delete "%%K" /v SkipBOSDescriptorQuery /f >nul 2>&1
    reg delete "%%K" /v SkipContainerIdQuery /f >nul 2>&1
    reg delete "%%K" /v MsOs20DescriptorSetInfo /f >nul 2>&1
    reg delete "%%K" /v DontSkipMsOsDescriptor /f >nul 2>&1
    reg delete "%%K" /v IgnoreBOSDescriptorValidationFailure /f >nul 2>&1
    reg delete "%%K" /v SkipSetSel /f >nul 2>&1
    reg delete "%%K" /v AlternateSettingFilter /f >nul 2>&1
    reg delete "%%K" /v RequestConfigDescOnReset /f >nul 2>&1
    reg delete "%%K" /v DisableFastEnumeration /f >nul 2>&1
)

echo Optimize USB Descriptor Validation and Enumeration restored successfully.

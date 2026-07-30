@echo off
title By Platinum+ Optimizer

:: Apply Descriptor and Enumeration overrides to all existing device subkeys
for /f "delims=" %%K in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" 2^>nul') do (
    reg add "%%K" /v IgnoreHWSerNum /t REG_BINARY /d 01000000 /f >nul 2>&1
    reg add "%%K" /v UseWin8DescriptorValidation /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v osvc /t REG_BINARY /d 0000 /f >nul 2>&1
    reg add "%%K" /v SkipBOSDescriptorQuery /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v SkipContainerIdQuery /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v MsOs20DescriptorSetInfo /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v DontSkipMsOsDescriptor /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v IgnoreBOSDescriptorValidationFailure /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v SkipSetSel /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%K" /v AlternateSettingFilter /t REG_BINARY /d 00000000 /f >nul 2>&1
    reg add "%%K" /v RequestConfigDescOnReset /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%K" /v DisableFastEnumeration /t REG_DWORD /d 0 /f >nul 2>&1
)

echo Optimize USB Descriptor Validation and Enumeration applied successfully.

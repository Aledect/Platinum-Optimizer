@echo off
title By Platinum+ Optimizer

:: Loop through all installed Network Adapters and apply maximum performance settings
for /f "tokens=*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}" ^| findstr /R "\\00[0-9][0-9]$"') do (
    reg add "%%a" /v "*DeviceSleepOnDisconnect" /t REG_SZ /d "0" /f
    reg add "%%a" /v "*EnableDynamicPowerGating" /t REG_SZ /d "0" /f
    reg add "%%a" /v "DisableIntelRST" /t REG_SZ /d "1" /f
    reg add "%%a" /v "DMACoalescing" /t REG_SZ /d "0" /f
    reg add "%%a" /v "EnableDisconnectedStandby" /t REG_SZ /d "0" /f
    reg add "%%a" /v "EnableModernStandby" /t REG_SZ /d "0" /f
    reg add "%%a" /v "EnablePME" /t REG_SZ /d "0" /f
    reg add "%%a" /v "EnablePowerManagement" /t REG_SZ /d "0" /f
    reg add "%%a" /v "ForceHostExitUlp" /t REG_SZ /d "1" /f
    reg add "%%a" /v "ForceLtrValue" /t REG_SZ /d "0" /f
    reg add "%%a" /v "I218DisablePLLShut" /t REG_SZ /d "1" /f
    reg add "%%a" /v "I218DisablePLLShutGiga" /t REG_SZ /d "1" /f
    reg add "%%a" /v "I219DisableK1Off" /t REG_SZ /d "1" /f
    reg add "%%a" /v "ULPMode" /t REG_SZ /d "0" /f
    reg add "%%a" /v "*WakeOnPattern" /t REG_SZ /d "0" /f
    reg add "%%a" /v "*WakeOnMagicPacket" /t REG_SZ /d "0" /f
    reg add "%%a" /v "*EEE" /t REG_SZ /d "0" /f
    reg add "%%a" /v "*IdleRestriction" /t REG_SZ /d "0" /f
    reg add "%%a" /v "*ModernStandbyWoLMagicPacket" /t REG_SZ /d "0" /f
    reg add "%%a" /v "*SelectiveSuspend" /t REG_SZ /d "0" /f
    reg add "%%a" /v "*SSIdleTimeout" /t REG_SZ /d "0" /f
    reg add "%%a" /v "*SSIdleTimeoutScreenOff" /t REG_SZ /d "0" /f
    reg add "%%a" /v "AdvancedEEE" /t REG_SZ /d "0" /f
    reg add "%%a" /v "AutoPowerSaveModeEnabled" /t REG_SZ /d "0" /f
    reg add "%%a" /v "EnableGreenEthernet" /t REG_SZ /d "0" /f
    reg add "%%a" /v "GigaLite" /t REG_SZ /d "0" /f
    reg add "%%a" /v "PowerSavingMode" /t REG_SZ /d "0" /f
    reg add "%%a" /v "ReduceSpeedOnPowerDown" /t REG_SZ /d "0" /f
    reg add "%%a" /v "WolShutdownLinkSpeed" /t REG_SZ /d "2" /f
    reg add "%%a" /v "DynamicLTR" /t REG_SZ /d "0" /f
    reg add "%%a" /v "EnableAdvancedDynamicITR" /t REG_SZ /d "0" /f
    reg add "%%a" /v "S3S4WolPowerSaving" /t REG_SZ /d "0" /f
    reg add "%%a" /v "AutoLinkDownPcieMacOff" /t REG_SZ /d "0" /f
    reg add "%%a" /v "BatteryModeLinkSpeed" /t REG_SZ /d "2" /f
    reg add "%%a" /v "CLKREQ" /t REG_SZ /d "0" /f
    reg add "%%a" /v "EnableCoalesce" /t REG_SZ /d "0" /f
    reg add "%%a" /v "CoalesceBufferSize" /t REG_SZ /d "0" /f
    reg add "%%a" /v "*PacketCoalescing" /t REG_SZ /d "0" /f
    reg add "%%a" /v "SVOFFMode" /t REG_SZ /d "0" /f
    reg add "%%a" /v "SVOFFModeHWM" /t REG_SZ /d "0" /f
    reg add "%%a" /v "SVOFFModeTimer" /t REG_SZ /d "0" /f
    reg add "%%a" /v "EnabledDatapathCycleCounters" /t REG_SZ /d "0" /f
    reg add "%%a" /v "EnabledDatapathEventCounters" /t REG_SZ /d "0" /f
)

echo Disable Power Savings and Coalescing for Network Adapters applied successfully.

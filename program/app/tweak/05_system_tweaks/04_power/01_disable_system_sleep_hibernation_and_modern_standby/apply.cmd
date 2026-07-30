@echo off
title By Platinum+ Optimizer

set "PWR=HKLM\SYSTEM\CurrentControlSet\Control\Power"

:: Disable Hibernation and Fast Startup
reg add "%PWR%" /v "AllowHibernate" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "EnableMinimalHiberFile" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "ForceMinimalHiberFile" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "HiberFileSizePercent" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "HiberFileType" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "HiberFileTypeDefault" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "HibernateBootOptimizationEnabled" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "HibernateChecksummingEnabled" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "HibernateEnabledDefault" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "HibernateEnabled" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "PromoteHibernateToShutdown" /t REG_DWORD /d 1 /f
reg add "%PWR%" /v "SkipHibernateMemoryMapValidation" /t REG_DWORD /d 1 /f

:: Disable Modern Standby and DRIPS
reg add "%PWR%" /v "MSDisabled" /t REG_DWORD /d 1 /f
reg add "%PWR%" /v "CheckpointSystemSleep" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "CheckpointSystemSleepSimulateFlags" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DirectedDripsAction" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DirectedDripsDebounceInterval" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DirectedDripsDfxEnforcementPolicy" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DirectedDripsOverride" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DirectedDripsSurprisePowerOnTimeout" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DirectedDripsTimeout" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DirectedDripsWaitWakeTimeout" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DirectedFxDefaultTimeout" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DripsCallbackInterval" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DripsSwHwDivergenceEnableLiveDump" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "DripsSwHwDivergenceThreshold" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "TimerRebaseThresholdOnDripsExit" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "RestrictedStandbyDozeTimeoutSeconds" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "StandbyConnectivityGracePeriod" /t REG_DWORD /d 0 /f
reg add "%PWR%" /v "EnforceDisconnectedStandby" /t REG_DWORD /d 0 /f

:: Force Hibernate Disabled Policy
reg add "%PWR%\ForceHibernateDisabled" /v "GuardedHost" /t REG_DWORD /d 1 /f
reg add "%PWR%\ForceHibernateDisabled" /v "Policy" /t REG_DWORD /d 1 /f

:: Modern Sleep Policies
reg add "%PWR%\ModernSleep" /v "EnabledActions" /t REG_DWORD /d 0 /f
reg add "%PWR%\ModernSleep" /v "EnableDsNetRefresh" /t REG_DWORD /d 0 /f

:: Zero out HiberFileBuckets
reg add "%PWR%\HiberFileBucket" /v "Percent16GBFull" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent16GBReduced" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent1GBFull" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent1GBReduced" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent2GBFull" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent2GBReduced" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent32GBFull" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent32GBReduced" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent4GBFull" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent4GBReduced" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent8GBFull" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "Percent8GBReduced" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "PercentUnlimitedFull" /t REG_DWORD /d 0 /f
reg add "%PWR%\HiberFileBucket" /v "PercentUnlimitedReduced" /t REG_DWORD /d 0 /f

echo Disable System Sleep, Hibernation, and Modern Standby applied successfully.

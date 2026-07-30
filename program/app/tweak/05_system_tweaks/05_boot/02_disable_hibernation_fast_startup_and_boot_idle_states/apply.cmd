@echo off
title By Platinum+ Optimizer

:: Disable Hibernation via powercfg
powercfg /hibernate off

:: Core Power and Hibernation Parameters
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "AllowHibernate" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnableMinimalHiberFile" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ForceMinimalHiberFile" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateChecksummingEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabledDefault" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PromoteHibernateToShutdown" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "SkipHibernateMemoryMapValidation" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateBootOptimizationEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HiberFileSizePercent" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HiberFileType" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HiberFileTypeDefault" /t REG_DWORD /d 0 /f

:: Disable Idle States At Boot (2 = Maximum Disable for Coordinated, Platform, and New Idle States)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableIdleStatesAtBoot" /t REG_DWORD /d 2 /f

:: Force Hibernate Disabled Policies
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ForceHibernateDisabled" /v "GuardedHost" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ForceHibernateDisabled" /v "Policy" /t REG_DWORD /d 1 /f

:: Session Manager Power Counters and Fast Startup
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HybridBootAnimationTime" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberIoCpuTime" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "ResumeCompleteTimestamp" /t REG_QWORD /d 0 /f

:: Windows System Policies for Fast Startup
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f

:: Zero out HiberFileBucket Allocations
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent16GBFull" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent16GBReduced" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent1GBFull" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent1GBReduced" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent2GBFull" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent2GBReduced" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent32GBFull" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent32GBReduced" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent4GBFull" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent4GBReduced" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent8GBFull" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "Percent8GBReduced" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "PercentUnlimitedFull" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\HiberFileBucket" /v "PercentUnlimitedReduced" /t REG_DWORD /d 0 /f

echo Disable Hibernation, Fast Startup, and Boot Idle States applied successfully.

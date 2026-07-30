@echo off
title By Platinum+ Optimizer

:: Restore NVMe Idle Power States and Timeouts to Defaults
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IdlePowerMode /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MedPowerFxIdleTimeout /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v LowestPowerFxIdleTimeout /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MedPowerD3IdleTimeout /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v LowestPowerD3IdleTimeout /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MedPowerResumeLatency /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v LowestPowerResumeLatency /f >nul 2>&1

echo Disable NVMe Idle Power States and Resume Latency restored successfully.

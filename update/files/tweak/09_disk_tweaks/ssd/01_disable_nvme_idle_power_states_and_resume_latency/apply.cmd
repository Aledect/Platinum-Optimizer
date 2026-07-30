@echo off
title By Platinum+ Optimizer

:: Disable NVMe Idle Power States and Maximize Timeouts
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IdlePowerMode /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MedPowerFxIdleTimeout /t REG_MULTI_SZ /d "4294967295" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v LowestPowerFxIdleTimeout /t REG_MULTI_SZ /d "4294967295" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MedPowerD3IdleTimeout /t REG_MULTI_SZ /d "4294967295" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v LowestPowerD3IdleTimeout /t REG_MULTI_SZ /d "4294967295" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MedPowerResumeLatency /t REG_MULTI_SZ /d "4294967295" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v LowestPowerResumeLatency /t REG_MULTI_SZ /d "4294967295" /f

echo Disable NVMe Idle Power States and Resume Latency applied successfully.

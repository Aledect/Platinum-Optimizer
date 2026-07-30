@echo off
title By Platinum+ Optimizer
:: Since these are primarily placeholder paths, deleting the injected keys restores the default state safely.
set "BASE=HKLM\SYSTEM\CurrentControlSet\Enum\Target_Enumerator\Target_DeviceID\Target_InstanceID\Device Parameters"
reg delete "%BASE%\Interrupt Management" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Enum\Target_Enumerator\Target_DeviceID\Target_InstanceID" /f
echo Optimize Interrupt Management and Affinity Policy restored successfully.

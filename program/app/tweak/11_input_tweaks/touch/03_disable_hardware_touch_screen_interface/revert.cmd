@echo off
title By Platinum+ Optimizer

:: Restore HID-Compliant Touch Screen Hardware Interface
powershell -NoProfile -Command "Get-PnpDevice -PresentOnly:$false | Where-Object FriendlyName -eq 'HID-compliant touch screen' | ForEach-Object { pnputil /enable-device \"$($_.InstanceId)\" }"

echo Disable Hardware Touch Screen Interface restored successfully.

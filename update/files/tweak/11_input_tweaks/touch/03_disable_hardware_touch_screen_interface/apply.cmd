@echo off
title By Platinum+ Optimizer

:: Disable HID-Compliant Touch Screen Hardware Interface
powershell -NoProfile -Command "Get-PnpDevice -PresentOnly:$false | Where-Object FriendlyName -eq 'HID-compliant touch screen' | ForEach-Object { pnputil /disable-device \"$($_.InstanceId)\" }"

echo Disable Hardware Touch Screen Interface applied successfully.

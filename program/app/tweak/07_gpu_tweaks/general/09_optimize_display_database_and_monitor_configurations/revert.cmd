@echo off
title By Platinum+ Optimizer
reg delete "HKLM\System\CurrentControlSet\Control\UnitedVideo\CONTROL\VIDEO\{0096AEE5-861E-11F0-896E-806E6F6E6963}\0000\DefaultSettings.Orientation" /f
reg delete "HKLM\System\CurrentControlSet\Control\GraphicsDrivers\Config" /ve /f
reg delete "HKLM\System\CurrentControlSet\Control\GraphicsDrivers\Configuration\MSI3CB01222_2E_07E4" /f
reg delete "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /f
reg delete "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\ADAPTER_10" /f
reg delete "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\CONNECTOR_" /f
reg delete "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase" /v "1641970V" /f
reg delete "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase" /v "EdidLock" /f
reg delete "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MSI3CB01222_2E_07E4" /f
reg delete "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /f
echo Restore Display Database defaults applied successfully.

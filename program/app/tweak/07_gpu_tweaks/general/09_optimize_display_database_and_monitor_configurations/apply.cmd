@echo off
title By Platinum+ Optimizer
reg add "HKLM\System\CurrentControlSet\Control\UnitedVideo\CONTROL\VIDEO\{0096AEE5-861E-11F0-896E-806E6F6E6963}\0000\DefaultSettings.Orientation" /v "Type" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\GraphicsDrivers\Config" /ve /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Control\GraphicsDrivers\Configuration\MSI3CB01222_2E_07E4" /v "Rotation" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /v "BrightnessCalibrationDataRegistryKey" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /v "ColorformatConfig" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /v "DitherRegistryKey" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /v "DPLinkConfigDataRegistryKey" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /v "MonitorDataRegistryKey" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /v "SaturationRegistryKey" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /v "SmoothScalingData" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /v "SmoothScalingMultiplierData" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /v "UpScalingMultiplierData" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MONITORXXX" /v "ScalingConfig" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\ADAPTER_10" /v "StereoPreferredTargetIdRegistryKey" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\ADAPTER_10" /v "MergedDisplayDataRegistryKey" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\ADAPTER_10" /v "StreamCloneState" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\CONNECTOR_" /v "ConnectorWarpResamplingMethod" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\CONNECTOR_" /v "ConnectorAudioData" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\CONNECTOR_" /v "ConnectorAudioDpAddress" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\CONNECTOR_" /v "DEStateRegistryKey" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase" /v "1641970V" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase" /v "EdidLock" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\State\DisplayDatabase\MSI3CB01222_2E_07E4" /v "HueRegistryKey" /t REG_BINARY /d DB010000140000001027000000000000 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "3538946" /t REG_DWORD /d 100 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "3538947" /t REG_DWORD /d 100 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "3538948" /t REG_DWORD /d 100 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "3538949" /t REG_DWORD /d 100 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "3538950" /t REG_DWORD /d 100 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "3538951" /t REG_DWORD /d 100 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "3538952" /t REG_DWORD /d 100 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "3538953" /t REG_DWORD /d 100 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "3538954" /t REG_DWORD /d 100 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "3538970" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\NVIDIA Corporation\Global\NVTweak\Devices\1364265386-0\Color" /v "NvCplGammaSet" /t REG_DWORD /d 1 /f
echo Optimize Display Database and Monitor Configurations applied successfully.

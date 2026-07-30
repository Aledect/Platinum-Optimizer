@echo off
title By Platinum+ Optimizer
sc config "XboxGipSvc" start= disabled
sc stop "XboxGipSvc"
sc config "xboxgip" start= disabled
sc stop "xboxgip"
sc config "XblAuthManager" start= disabled
sc stop "XblAuthManager"
sc config "XblGameSave" start= disabled
sc stop "XblGameSave"
sc config "XboxNetApiSvc" start= disabled
sc stop "XboxNetApiSvc"
sc config "EpicGamesUpdater" start= disabled
sc stop "EpicGamesUpdater"
sc config "EpicOnlineServices" start= disabled
sc stop "EpicOnlineServices"
sc config "LGHUBUpdaterService" start= disabled
sc stop "LGHUBUpdaterService"
sc config "logi_joy_bus_enum" start= disabled
sc stop "logi_joy_bus_enum"
sc config "logi_joy_vir_hid" start= disabled
sc stop "logi_joy_vir_hid"
sc config "logi_lamparray_service" start= disabled
sc stop "logi_lamparray_service"
sc config "SteelSeries_Sonar_VAD" start= disabled
sc stop "SteelSeries_Sonar_VAD"
sc config "SteelSeriesGGUpdateServiceProxy" start= disabled
sc stop "SteelSeriesGGUpdateServiceProxy"
sc config "ssdevfactory" start= disabled
sc stop "ssdevfactory"
sc config "NVDisplay.ContainerLocalSystem" start= disabled
sc stop "NVDisplay.ContainerLocalSystem"
sc config "Everything" start= disabled
sc stop "Everything"
sc config "GameInputSvc" start= disabled
sc stop "GameInputSvc"
echo Disable Gaming, Xbox, and Third-Party Peripherals for GPU/Input applied successfully.
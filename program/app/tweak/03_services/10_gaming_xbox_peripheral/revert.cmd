@echo off
title By Platinum+ Optimizer
sc config "XboxGipSvc" start= demand
sc config "xboxgip" start= demand
sc config "XblAuthManager" start= demand
sc config "XblGameSave" start= demand
sc config "XboxNetApiSvc" start= demand
sc config "EpicGamesUpdater" start= demand
sc config "EpicOnlineServices" start= demand
sc config "LGHUBUpdaterService" start= demand
sc config "logi_joy_bus_enum" start= demand
sc config "logi_joy_vir_hid" start= demand
sc config "logi_lamparray_service" start= demand
sc config "SteelSeries_Sonar_VAD" start= demand
sc config "SteelSeriesGGUpdateServiceProxy" start= demand
sc config "ssdevfactory" start= demand
sc config "NVDisplay.ContainerLocalSystem" start= demand
sc config "Everything" start= demand
sc config "GameInputSvc" start= demand
echo Restore Gaming, Xbox, and Third-Party Peripherals for GPU/Input applied successfully.
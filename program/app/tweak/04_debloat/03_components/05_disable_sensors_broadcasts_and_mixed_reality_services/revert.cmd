@echo off
title By Platinum+ Optimizer
sc config "SensorDataService" start= demand
sc config "SensrSvc" start= demand
sc config "SensorService" start= demand
sc config "perceptionsimulation" start= demand
sc config "spectrum" start= demand
sc config "VacSvc" start= demand
sc config "BcastDVRUserService" start= demand
sc config "CaptureService" start= demand
for /f "tokens=1" %%i in ('sc query ^| findstr /I "CaptureService_"') do (
    sc config "%%i" start= demand
)
sc config "AJRouter" start= demand
sc config "CDPSvc" start= demand
sc config "CDPUserSvc" start= demand
sc config "DevicePickerUserSvc" start= demand
sc config "DevicesFlowUserSvc" start= demand
sc config "NcbService" start= demand
sc config "NcdAutoSetup" start= demand
sc config "lfsvc" start= demand
sc config "MapsBroker" start= demand
sc config "CompositeBus" start= demand
sc config "umbus" start= demand
echo Restore Sensors, Broadcasts, and Mixed Reality for Rendering/CPU applied successfully.

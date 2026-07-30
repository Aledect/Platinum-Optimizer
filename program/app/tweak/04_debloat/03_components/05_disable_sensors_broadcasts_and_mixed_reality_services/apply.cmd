@echo off
title By Platinum+ Optimizer
sc config "SensorDataService" start= disabled
sc stop "SensorDataService"
sc config "SensrSvc" start= disabled
sc stop "SensrSvc"
sc config "SensorService" start= disabled
sc stop "SensorService"
sc config "perceptionsimulation" start= disabled
sc stop "perceptionsimulation"
sc config "spectrum" start= disabled
sc stop "spectrum"
sc config "VacSvc" start= disabled
sc stop "VacSvc"
sc config "BcastDVRUserService" start= disabled
sc stop "BcastDVRUserService"
sc config "CaptureService" start= disabled
sc stop "CaptureService"
for /f "tokens=1" %%i in ('sc query ^| findstr /I "CaptureService_"') do (
    sc config "%%i" start= disabled
    sc stop "%%i"
)
sc config "AJRouter" start= disabled
sc stop "AJRouter"
sc config "CDPSvc" start= disabled
sc stop "CDPSvc"
sc config "CDPUserSvc" start= disabled
sc stop "CDPUserSvc"
sc config "DevicePickerUserSvc" start= disabled
sc stop "DevicePickerUserSvc"
sc config "DevicesFlowUserSvc" start= disabled
sc stop "DevicesFlowUserSvc"
sc config "NcbService" start= disabled
sc stop "NcbService"
sc config "NcdAutoSetup" start= disabled
sc stop "NcdAutoSetup"
sc config "lfsvc" start= disabled
sc stop "lfsvc"
sc config "MapsBroker" start= disabled
sc stop "MapsBroker"
sc config "CompositeBus" start= disabled
sc stop "CompositeBus"
sc config "umbus" start= disabled
sc stop "umbus"
echo Disable Sensors, Broadcasts, and Mixed Reality for Rendering/CPU applied successfully.

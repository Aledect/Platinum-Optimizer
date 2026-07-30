@echo off
title By Platinum+ Optimizer
sc config "BTAGService" start= demand
sc config "BluetoothUserService" start= demand
for /f "tokens=1" %%i in ('sc query ^| findstr /I "BluetoothUserService_"') do (
    sc config "%%i" start= demand
)
sc config "BthA2dp" start= demand
sc config "BthAvctpSvc" start= demand
sc config "BthEnum" start= demand
sc config "BthHFEnum" start= demand
sc config "BthLEEnum" start= demand
sc config "BthMini" start= demand
sc config "BTHMODEM" start= demand
sc config "BTHPORT" start= demand
sc config "bthserv" start= demand
sc config "BTHUSB" start= demand
sc config "DeviceAssociationBrokerSvc" start= demand
sc config "DeviceAssociationService" start= demand
sc config "Microsoft_Bluetooth_AvrcpTransport" start= demand
sc config "RFCOMM" start= demand
sc config "WlanSvc" start= auto
sc config "vwififlt" start= demand
sc config "wcncsvc" start= demand
sc config "WFDSConMgrSvc" start= demand
sc config "NativeWifiP" start= demand
sc config "Wificx" start= demand
sc config "WPDBusEnum" start= demand
sc config "WMPNetworkSvc" start= demand
sc config "PeerDistSvc" start= demand
sc config "icssvc" start= demand
sc config "wlpasvc" start= demand
sc config "WwanSvc" start= demand
echo Restore Bluetooth, Wi-Fi, and Portable Devices for Hardware Polling applied successfully.
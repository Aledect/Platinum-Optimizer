@echo off
title By Platinum+ Optimizer
sc config "BTAGService" start= disabled
sc stop "BTAGService"
sc config "BluetoothUserService" start= disabled
sc stop "BluetoothUserService"
for /f "tokens=1" %%i in ('sc query ^| findstr /I "BluetoothUserService_"') do (
    sc config "%%i" start= disabled
    sc stop "%%i"
)
sc config "BthA2dp" start= disabled
sc stop "BthA2dp"
sc config "BthAvctpSvc" start= disabled
sc stop "BthAvctpSvc"
sc config "BthEnum" start= disabled
sc stop "BthEnum"
sc config "BthHFEnum" start= disabled
sc stop "BthHFEnum"
sc config "BthLEEnum" start= disabled
sc stop "BthLEEnum"
sc config "BthMini" start= disabled
sc stop "BthMini"
sc config "BTHMODEM" start= disabled
sc stop "BTHMODEM"
sc config "BTHPORT" start= disabled
sc stop "BTHPORT"
sc config "bthserv" start= disabled
sc stop "bthserv"
sc config "BTHUSB" start= disabled
sc stop "BTHUSB"
sc config "DeviceAssociationBrokerSvc" start= disabled
sc stop "DeviceAssociationBrokerSvc"
sc config "DeviceAssociationService" start= disabled
sc stop "DeviceAssociationService"
sc config "Microsoft_Bluetooth_AvrcpTransport" start= disabled
sc stop "Microsoft_Bluetooth_AvrcpTransport"
sc config "RFCOMM" start= disabled
sc stop "RFCOMM"
sc config "WlanSvc" start= disabled
sc stop "WlanSvc"
sc config "vwififlt" start= disabled
sc stop "vwififlt"
sc config "wcncsvc" start= disabled
sc stop "wcncsvc"
sc config "WFDSConMgrSvc" start= disabled
sc stop "WFDSConMgrSvc"
sc config "NativeWifiP" start= disabled
sc stop "NativeWifiP"
sc config "Wificx" start= disabled
sc stop "Wificx"
sc config "WPDBusEnum" start= disabled
sc stop "WPDBusEnum"
sc config "WMPNetworkSvc" start= disabled
sc stop "WMPNetworkSvc"
sc config "PeerDistSvc" start= disabled
sc stop "PeerDistSvc"
sc config "icssvc" start= disabled
sc stop "icssvc"
sc config "wlpasvc" start= disabled
sc stop "wlpasvc"
sc config "WwanSvc" start= disabled
sc stop "WwanSvc"
echo Disable Bluetooth, Wi-Fi, and Portable Devices for Hardware Polling applied successfully.
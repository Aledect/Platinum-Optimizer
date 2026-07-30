@echo off
title By Platinum+ Optimizer
sc config "bttflt" start= disabled
sc stop "bttflt"
sc config "gencounter" start= disabled
sc stop "gencounter"
sc config "hvcrash" start= disabled
sc stop "hvcrash"
sc config "HvHost" start= disabled
sc stop "HvHost"
sc config "hvservice" start= disabled
sc stop "hvservice"
sc config "hyperkbd" start= disabled
sc stop "hyperkbd"
sc config "HyperVideo" start= disabled
sc stop "HyperVideo"
sc config "storflt" start= disabled
sc stop "storflt"
sc config "Vid" start= disabled
sc stop "Vid"
sc config "vmbus" start= disabled
sc stop "vmbus"
sc config "vmgid" start= disabled
sc stop "vmgid"
sc config "vmicguestinterface" start= disabled
sc stop "vmicguestinterface"
sc config "vmicheartbeat" start= disabled
sc stop "vmicheartbeat"
sc config "vmickvpexchange" start= disabled
sc stop "vmickvpexchange"
sc config "vmicrdv" start= disabled
sc stop "vmicrdv"
sc config "vmicshutdown" start= disabled
sc stop "vmicshutdown"
sc config "vmictimesync" start= disabled
sc stop "vmictimesync"
sc config "vmicvmsession" start= disabled
sc stop "vmicvmsession"
sc config "vmicvss" start= disabled
sc stop "vmicvss"
sc config "vpci" start= disabled
sc stop "vpci"
sc config "VBoxNetAdp" start= disabled
sc stop "VBoxNetAdp"
sc config "VBoxNetLwf" start= disabled
sc stop "VBoxNetLwf"
sc config "VBoxSup" start= disabled
sc stop "VBoxSup"
sc config "VBoxUSBMon" start= disabled
sc stop "VBoxUSBMon"
sc config "VBoxSDS" start= disabled
sc stop "VBoxSDS"
sc config "CimFS" start= disabled
sc stop "CimFS"
sc config "wcifs" start= disabled
sc stop "wcifs"
sc config "vdrvroot" start= disabled
sc stop "vdrvroot"
sc config "NdisVirtualBus" start= disabled
sc stop "NdisVirtualBus"
echo Disable Virtualization, Hyper-V, and Containers for CPU Scheduling applied successfully.
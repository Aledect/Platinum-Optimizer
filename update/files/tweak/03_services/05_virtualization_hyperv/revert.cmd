@echo off
title By Platinum+ Optimizer
sc config "bttflt" start= demand
sc config "gencounter" start= demand
sc config "hvcrash" start= demand
sc config "HvHost" start= demand
sc config "hvservice" start= demand
sc config "hyperkbd" start= demand
sc config "HyperVideo" start= demand
sc config "storflt" start= demand
sc config "Vid" start= demand
sc config "vmbus" start= demand
sc config "vmgid" start= demand
sc config "vmicguestinterface" start= demand
sc config "vmicheartbeat" start= demand
sc config "vmickvpexchange" start= demand
sc config "vmicrdv" start= demand
sc config "vmicshutdown" start= demand
sc config "vmictimesync" start= demand
sc config "vmicvmsession" start= demand
sc config "vmicvss" start= demand
sc config "vpci" start= demand
sc config "VBoxNetAdp" start= demand
sc config "VBoxNetLwf" start= demand
sc config "VBoxSup" start= demand
sc config "VBoxUSBMon" start= demand
sc config "VBoxSDS" start= demand
sc config "CimFS" start= demand
sc config "wcifs" start= demand
sc config "vdrvroot" start= demand
sc config "NdisVirtualBus" start= demand
echo Restore Virtualization, Hyper-V, and Containers for CPU Scheduling applied successfully.
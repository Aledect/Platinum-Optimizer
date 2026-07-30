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
echo Restore Hyper-V and Virtualization Services for CPU Scheduling applied successfully.

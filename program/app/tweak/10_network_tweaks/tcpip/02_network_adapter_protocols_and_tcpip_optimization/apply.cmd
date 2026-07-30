@echo off
title By Platinum+ Optimizer

powershell -NoProfile -Command "Disable-NetAdapterBinding -Name '*' -ComponentID vmware_bridge, ms_lldp, ms_lltdio, ms_implat, ms_rspndr -ErrorAction SilentlyContinue"

netsh interface isatap set state disabled
netsh int tcp set global timestamps=disabled
netsh int tcp set global rss=enabled
netsh int tcp set global nonsackrttresiliency=disabled
netsh int tcp set global autotuninglevel=normal
netsh int ip set global taskoffload=enabled

echo enable Network Protocols & TCP/IP Optimization applied successfully.

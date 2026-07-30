@echo off
title By Platinum+ Optimizer

powershell -NoProfile -Command "Enable-NetAdapterBinding -Name '*' -ComponentID vmware_bridge, ms_lldp, ms_lltdio, ms_implat, ms_tcpip6, ms_rspndr, ms_server, ms_msclient -ErrorAction SilentlyContinue"

netsh interface isatap set state default
netsh int tcp set global timestamps=default
netsh int tcp set global rss=default
netsh int tcp set global nonsackrttresiliency=default
netsh int tcp set global autotuninglevel=normal
netsh int ip set global taskoffload=default

echo restore Network Protocols & TCP/IP Optimization applied successfully.

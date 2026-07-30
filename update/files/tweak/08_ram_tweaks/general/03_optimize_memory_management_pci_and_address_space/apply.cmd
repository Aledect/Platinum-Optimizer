@echo off
title By Platinum+ Optimizer
bcdedit /deletevalue {current} pae
bcdedit /set {current} avoidlowphysicalmemory no
bcdedit /deletevalue {current} nolowmem
bcdedit /deletevalue {current} truncatememory
bcdedit /deletevalue {current} removememory
bcdedit /deletevalue {current} increaseuserva
bcdedit /deletevalue {current} perfmem
bcdedit /deletevalue {current} linearaddress57
bcdedit /deletevalue {current} relocatephysicalmemory
bcdedit /deletevalue {current} firstmegabytepolicy
bcdedit /deletevalue {current} pciexpress
bcdedit /deletevalue {current} msi
bcdedit /deletevalue {current} configflags
bcdedit /deletevalue {current} configaccesspolicy
bcdedit /deletevalue {current} usefirmwarepcisettings
bcdedit /deletevalue {current} stampdisks
bcdedit /deletevalue {current} allowprereleasesignatures
bcdedit /deletevalue {current} lastknowngood
echo Optimize Memory Management, PCI, and Physical Address Space applied successfully.

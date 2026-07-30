@echo off
title By Platinum+ Optimizer
bcdedit /set {current} hypervisorlaunchtype off
bcdedit /set {current} vsmlaunchtype off
bcdedit /set {current} hypervisordisableslat yes
bcdedit /set {current} hypervisoruselargevtlb yes
bcdedit /set {current} hypervisordebug no
bcdedit /set {current} hypervisoriommupolicy Disable
bcdedit /deletevalue {current} hypervisorrootproc
bcdedit /deletevalue {current} hypervisorrootprocpernode
bcdedit /deletevalue {current} hypervisornumproc
bcdedit /set {current} disableelamdrivers yes
bcdedit /set {current} nx OptIn
bcdedit /deletevalue {current} xsavedisable
bcdedit /deletevalue {current} xsaveprocessorsmask
bcdedit /deletevalue {current} xsaveremovefeature
bcdedit /deletevalue {current} xsaveaddfeature0
bcdedit /deletevalue {current} xsaveaddfeature1
bcdedit /deletevalue {current} xsaveaddfeature2
bcdedit /deletevalue {current} xsaveaddfeature3
bcdedit /deletevalue {current} xsaveaddfeature4
bcdedit /deletevalue {current} xsaveaddfeature5
bcdedit /deletevalue {current} xsaveaddfeature6
bcdedit /deletevalue {current} xsaveaddfeature7
bcdedit /deletevalue {current} xsavepolicy
bcdedit /deletevalue {current} tpmbootentropy
bcdedit /deletevalue {current} testsigning
bcdedit /deletevalue {current} nointegritychecks
bcdedit /deletevalue {current} integrityservices
bcdedit /set {current} forcefipscrypto no
bcdedit /set {current} isolatedcontext no
bcdedit /set {current} vm no
bcdedit /set {current} traditionalkseg no
bcdedit /deletevalue {current} allowedinmemorysettings
bcdedit /deletevalue {current} claimedtpmcounter
echo Disable Virtualization, Hypervisor, and ELAM Security Overhead applied successfully.

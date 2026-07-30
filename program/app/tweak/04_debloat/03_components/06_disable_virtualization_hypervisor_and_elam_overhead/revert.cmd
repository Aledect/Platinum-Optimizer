@echo off
title By Platinum+ Optimizer
bcdedit /deletevalue {current} hypervisorlaunchtype
bcdedit /deletevalue {current} vsmlaunchtype
bcdedit /deletevalue {current} hypervisordisableslat
bcdedit /deletevalue {current} hypervisoruselargevtlb
bcdedit /deletevalue {current} hypervisordebug
bcdedit /deletevalue {current} hypervisoriommupolicy
bcdedit /deletevalue {current} hypervisorrootproc
bcdedit /deletevalue {current} hypervisorrootprocpernode
bcdedit /deletevalue {current} hypervisornumproc
bcdedit /deletevalue {current} disableelamdrivers
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
bcdedit /deletevalue {current} forcefipscrypto
bcdedit /deletevalue {current} isolatedcontext
bcdedit /deletevalue {current} vm
bcdedit /deletevalue {current} traditionalkseg
bcdedit /deletevalue {current} allowedinmemorysettings
bcdedit /deletevalue {current} claimedtpmcounter
echo Restore Virtualization, Hypervisor, and ELAM Security Overhead applied successfully.

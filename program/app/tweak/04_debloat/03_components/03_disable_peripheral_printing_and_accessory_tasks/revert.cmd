@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\Printing\PrintJobCleanupTask" /enable
schtasks /change /tn "\Microsoft\Windows\Printing\PrinterCleanupTask" /enable
schtasks /change /tn "\Microsoft\Windows\Printing\EduPrintProv" /enable
schtasks /change /tn "\Microsoft\Windows\Speech\SpeechModelDownloadTask" /enable
schtasks /change /tn "\Microsoft\Windows\Maps\MapsUpdateTask" /enable
schtasks /change /tn "\Microsoft\Windows\Maps\MapsToastTask" /enable
echo Restore Peripheral, Printing, and Accessory Background Tasks applied successfully.

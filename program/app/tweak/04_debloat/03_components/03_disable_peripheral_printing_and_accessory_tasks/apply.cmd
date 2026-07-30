@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\Printing\PrintJobCleanupTask" /disable
schtasks /change /tn "\Microsoft\Windows\Printing\PrinterCleanupTask" /disable
schtasks /change /tn "\Microsoft\Windows\Printing\EduPrintProv" /disable
schtasks /change /tn "\Microsoft\Windows\Speech\SpeechModelDownloadTask" /disable
schtasks /change /tn "\Microsoft\Windows\Maps\MapsUpdateTask" /disable
schtasks /change /tn "\Microsoft\Windows\Maps\MapsToastTask" /disable
echo Disable Peripheral, Printing, and Accessory Background Tasks applied successfully.

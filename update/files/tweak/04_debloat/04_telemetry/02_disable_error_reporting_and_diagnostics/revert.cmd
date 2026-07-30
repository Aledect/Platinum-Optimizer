@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\ErrorDetails\EnableErrorDetailsUpdate" /enable
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /enable
schtasks /change /tn "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /enable
schtasks /change /tn "\Microsoft\Windows\Diagnosis\Scheduled" /enable
schtasks /change /tn "\Microsoft\Windows\Diagnosis\UnexpectedCodePath" /enable
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /enable
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /enable
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /enable
schtasks /change /tn "\Microsoft\Windows\MemoryDiagnostic\AutomaticOfflineMemoryDiagnostic" /enable
schtasks /change /tn "\Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents" /enable
schtasks /change /tn "\Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic" /enable
echo Restore Error Reporting and Automated Diagnostics applied successfully.

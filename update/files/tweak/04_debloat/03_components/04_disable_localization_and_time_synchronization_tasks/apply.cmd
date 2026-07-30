@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\International\Synchronize Language Settings" /disable
schtasks /change /tn "\Microsoft\Windows\LanguageComponentsInstaller\Installation" /disable
schtasks /change /tn "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" /disable
schtasks /change /tn "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /disable
schtasks /change /tn "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /disable
schtasks /change /tn "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /disable
echo Disable Localization and Time Synchronization Tasks applied successfully.

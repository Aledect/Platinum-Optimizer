@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\International\Synchronize Language Settings" /enable
schtasks /change /tn "\Microsoft\Windows\LanguageComponentsInstaller\Installation" /enable
schtasks /change /tn "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources" /enable
schtasks /change /tn "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /enable
schtasks /change /tn "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /enable
schtasks /change /tn "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /enable
echo Restore Localization and Time Synchronization Tasks applied successfully.

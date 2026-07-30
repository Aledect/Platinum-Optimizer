@echo off
title By Platinum+ Optimizer
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v DisableEnhancedNotifications /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v DisableNotifications /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender\UX Configuration" /v DisablePrivacyMode /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows Defender\UX Configuration" /v Notification_Suppress /f
echo Notifications and Privacy restored to stable maximum performance baseline.

@echo off
title By Platinum+ Optimizer

:: Restore Spatial Audio and Enhancements
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v GlobalDisableThirdPartyEnhancements /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v DisableSpatialAudioGlobal /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v DisableSpatialAudioPerEndpoint /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v DisableSpatialAudioVssFeature /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v SpatialAudioHrtfOnByDefault /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v DisableSpatialOnComboEndpoints /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v InboxAECPolicy /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v InboxAECPolicyCommsTmp /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v DevApiIsRunningInVM /t REG_DWORD /d 0 /f
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v RenderStreamVolumeTaperPower /f >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio\Policy\Spatial" /v SpatialAudioLicenseCheckStartDelay /t REG_DWORD /d 5 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio\Policy\Spatial" /v SpatialAudioLicenseCheckRequiresUserContext /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio\Spatial\AtmosLicenseDebug" /v AudioSrvLicenseResult /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio\Spatial\AtmosLicenseDebug" /v AudioDGLicenseResult /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\HoloSI\Audio" /v AudioMirroringEnabled /t REG_DWORD /d 0 /f
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\HoloSI\Audio" /v RoutedAudioDevice /f >nul 2>&1

:: Restore Audio Ducking
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v UserDuckingPreference /t REG_DWORD /d 1 /f

echo Disable Spatial Audio, Ducking, and Third-Party Enhancements restored successfully.

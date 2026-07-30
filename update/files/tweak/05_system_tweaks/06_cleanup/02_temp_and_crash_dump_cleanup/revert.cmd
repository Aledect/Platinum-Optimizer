@echo off
title By Platinum+ Optimizer

:: Restore WMP Telemetry, Metadata, and Online Features
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AcceptedPrivacyStatement" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "MetadataRetrieval" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SendUserGUID" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SilentAcquisition" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "ForceOnline" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UsageLoggerCategories" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableLicenseRefresh" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SilentDRMConfiguration" /f

:: Restore MRU (Most Recently Used) History Tracking
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableMRUMusic" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableMRUPictures" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableMRUVideo" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableMRUPlaylists" /f

:: Restore Setup and UI Preferences
reg delete "HKCU\Software\Microsoft\MediaPlayer\Setup\UserOptions" /v "DesktopShortcut" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AlwaysOnTopVTenSkin" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "EnableScreensaver" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AutoAddMusicToLibrary" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AutoAddUNC" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "PromptLicenseBackup" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "StopOnFastUserSwitch2" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "PlayerScriptCommandsEnabled" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "HTMLViewAsk" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "LocalSAMIFilesEnabled" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "WebScriptCommandsEnabled" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "WebStreamsEnabled" /f

:: Restore Network and Streaming Preferences
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "MaxBandwidth" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseUDP" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseCustomUDPPort" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseMulticast" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseTCP" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseHTTP" /f

:: Restore Video Rendering and Buffer Settings
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences\VideoSettings" /v "DontUseFrameInterpolation" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences\VideoSettings" /v "UseFullScrMS" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences\VideoSettings" /v "DVDUseVMRFSCntrls" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences\VideoSettings" /v "IgnoreAVSync" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences\VideoSettings" /v "UseVMRFullScreenCntr" /f
reg delete "HKCU\Software\Microsoft\Scrunch\WMVideo" /v "DXVA" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseDefaultBufferTime" /f
reg delete "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "CustomBufferTime" /f

:: Restore Global Video Playback App Settings
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\VideoSettings" /v "AllowLowResolution" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\VideoSettings" /v "EnableAutoEnhanceDuringPlayback" /f

:: Restore Notification Data Blobs (Delete overrides)
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Notifications\Data" /v "418A073AA3BC3475" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Notifications\Data" /v "418A073AA3BC2475" /f

:: Remove HME SID Restrictions
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\MediaPlayer\PREFERENCES\HME\S-1-5-21-312647486-298986" /f

echo Restore WMPlayer Telemetry and Optimize Video Playback applied successfully.

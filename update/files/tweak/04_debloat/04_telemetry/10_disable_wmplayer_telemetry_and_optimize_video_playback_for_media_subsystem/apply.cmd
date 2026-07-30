@echo off
title By Platinum+ Optimizer

:: Disable WMP Telemetry, Metadata, and Online Features
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AcceptedPrivacyStatement" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "MetadataRetrieval" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SendUserGUID" /t REG_BINARY /d 00 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SilentAcquisition" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "ForceOnline" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UsageLoggerCategories" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableLicenseRefresh" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "SilentDRMConfiguration" /t REG_DWORD /d 0 /f

:: Disable MRU (Most Recently Used) History Tracking
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableMRUMusic" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableMRUPictures" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableMRUVideo" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "DisableMRUPlaylists" /t REG_DWORD /d 1 /f

:: Configure Setup and UI Preferences
reg add "HKCU\Software\Microsoft\MediaPlayer\Setup\UserOptions" /v "DesktopShortcut" /t REG_SZ /d "no" /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AlwaysOnTopVTenSkin" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "EnableScreensaver" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AutoAddMusicToLibrary" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "AutoAddUNC" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "PromptLicenseBackup" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "StopOnFastUserSwitch2" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "PlayerScriptCommandsEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "HTMLViewAsk" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "LocalSAMIFilesEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "WebScriptCommandsEnabled" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "WebStreamsEnabled" /t REG_DWORD /d 1 /f

:: Configure Network and Streaming Preferences
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "MaxBandwidth" /t REG_DWORD /d 2147483647 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseUDP" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseCustomUDPPort" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseMulticast" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseTCP" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseHTTP" /t REG_DWORD /d 1 /f

:: Configure Video Rendering and Buffer Settings
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences\VideoSettings" /v "DontUseFrameInterpolation" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences\VideoSettings" /v "UseFullScrMS" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences\VideoSettings" /v "DVDUseVMRFSCntrls" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences\VideoSettings" /v "IgnoreAVSync" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences\VideoSettings" /v "UseVMRFullScreenCntr" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Scrunch\WMVideo" /v "DXVA" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "UseDefaultBufferTime" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\MediaPlayer\Preferences" /v "CustomBufferTime" /t REG_DWORD /d 5000 /f

:: Global Video Playback App Settings
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\VideoSettings" /v "AllowLowResolution" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\VideoSettings" /v "EnableAutoEnhanceDuringPlayback" /t REG_DWORD /d 0 /f

:: Overwrite Notification Data Blobs
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Notifications\Data" /v "418A073AA3BC3475" /t REG_BINARY /d 7A010000000000000400040001021C00 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Notifications\Data" /v "418A073AA3BC2475" /t REG_BINARY /d 3B03000000000000040004000100F101 /f

:: Apply HME SID Restrictions
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\MediaPlayer\PREFERENCES\HME\S-1-5-21-312647486-298986" /v "State1" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\MediaPlayer\PREFERENCES\HME\S-1-5-21-312647486-298986" /v "State2" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\MediaPlayer\PREFERENCES\HME\S-1-5-21-312647486-298986" /v "State3" /t REG_DWORD /d 0 /f

echo Disable WMPlayer Telemetry and Optimize Video Playback applied successfully.

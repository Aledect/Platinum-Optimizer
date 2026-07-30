@echo off
title By Platinum+ Optimizer

:: Restore Global GameDVR Policy
reg delete "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /f

:: Restore all GameDVR Capture, Encoding, and Hotkey Settings by removing overrides
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioEncodingBitrate" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CustomVideoEncodingBitrate" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CustomVideoEncodingHeight" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CustomVideoEncodingWidth" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalBufferLength" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalBufferLengthUnit" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureOnBatteryAllowed" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureOnWirelessDisplayAllowed" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "MaximumRecordLength" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VideoEncodingBitrateMode" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VideoEncodingResolutionMode" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VideoEncodingFrameRateMode" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "EchoCancellationEnabled" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKToggleGameBar" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKMToggleGameBar" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKSaveHistoricalVideo" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKMSaveHistoricalVideo" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKToggleRecording" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKMToggleRecording" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKTakeScreenshot" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKMTakeScreenshot" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKToggleRecordingIndicator" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKMToggleRecordingIndicator" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKToggleMicrophoneCapture" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKMToggleMicrophoneCapture" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKToggleCameraCapture" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKMToggleCameraCapture" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKToggleBroadcast" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "VKMToggleBroadcast" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "MicrophoneCaptureEnabled" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "SystemAudioGain" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "MicrophoneGain" /f

:: Restore all AppBroadcast Global Settings by removing overrides
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings" /v "AudioCaptureEnabled" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings" /v "MicrophoneCaptureEnabledByDefault" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings" /v "EchoCancellationEnabled" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings" /v "CursorCaptureEnabled" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings" /v "SystemAudioGain" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings" /v "MicrophoneGain" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings" /v "CameraCaptureEnabledByDefault" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings" /v "CameraOverlayLocation" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings" /v "CameraOverlaySize" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings" /v "SelectedCameraId" /f

echo Restore GameDVR and Xbox Game Bar applied successfully.
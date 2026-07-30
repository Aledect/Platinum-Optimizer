@echo off
title By Platinum+ Optimizer

:: Disable Tablet PC Policies and Features
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v TurnOffTouchInput /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v DisableInkball /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v DisableJournal /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v DisableNoteWriterPrinting /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v DisableSnippingTool /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v TurnOffPenFeedback /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v PreventFlicksLearningMode /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v PreventFlicks /t REG_DWORD /d 1 /f

:: Disable TabletTip (On-Screen Keyboard) Policies
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v DisablePrediction /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v DisableACIntegration /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v DisableEdgeTarget /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v HideIPTIPTargets /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v HideIPTIPTouchTargets /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v PasswordSecurityState /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v IncludeRareChar /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v ScratchOutState /t REG_DWORD /d 3 /f

:: Disable TabletTip Auto-Invoke and Visibility
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableDesktopModeAutoInvoke /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableDesktopModePenAutoInvoke /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v LastTipXPositionOnScreen /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v TipbandDesiredVisibility /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v TipbandDesiredVisibilityTabletMode /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v TipPinnedToMonitor /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v TouchKeyboardTapInvoke /t REG_DWORD /d 0 /f

:: Disable Wisp Touch Physics and Delays
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v PanningDisabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Inertia /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Bouncing /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Friction /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchModeN_DtapDist /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchModeN_DtapTime /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchGate /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchModeN_HoldTime_Animation /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchModeN_HoldTime_BeforeAnimation /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchMode_hold /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Mobile_Inertia_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Minimum_Velocity /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Thumb_Flick_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\MultiTouch" /v MultiTouchEnabled /t REG_DWORD /d 0 /f

:: Disable Wisp Pen Gestures and Processing
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v Splash /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v DblDist /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v DblTime /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v TapTime /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v WaitTime /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v HoldTime /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v FlickMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v FlickTolerance /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v Latency /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v SampleTime /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v UseHWTimeStamp /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v SguiMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v HoldMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v MouseInputResolutionX /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v MouseInputResolutionY /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v MouseInputFrequency /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v EraseEnable /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v RightMaskEnable /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v Color /t REG_DWORD /d 0 /f

:: Remove Hexadecimal Flick Commands
reg delete "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v Left /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v UpLeft /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v Up /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v UpRight /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v Right /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v DownRight /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v Down /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v DownLeft /f >nul 2>&1

:: Disable Tablet Mode and Immersive Shell Scaling
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TabletMode" /v STCDefaultMigrationCompleted /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v ExitedTabletModeWhileCSMActive /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletModeActivated /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletModeCoverWindow /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletModeInputHandler /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v AllowPPITabletModeExit /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell\OverrideScaling" /v SmallScreen /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell\OverrideScaling" /v VerySmallScreen /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell\OverrideScaling" /v TabletSmallScreen /t REG_DWORD /d 0 /f

echo Disable Touch, Pen, and Tablet UI Features applied successfully.

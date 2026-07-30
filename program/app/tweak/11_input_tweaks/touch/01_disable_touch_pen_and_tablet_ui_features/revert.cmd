@echo off
title By Platinum+ Optimizer

:: Restore Tablet PC Policies and Features
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v TurnOffTouchInput /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v DisableInkball /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v DisableJournal /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v DisableNoteWriterPrinting /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v DisableSnippingTool /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v TurnOffPenFeedback /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v PreventFlicksLearningMode /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletPC" /v PreventFlicks /f >nul 2>&1

:: Restore TabletTip (On-Screen Keyboard) Policies
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v DisablePrediction /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v DisableACIntegration /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v DisableEdgeTarget /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v HideIPTIPTargets /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v HideIPTIPTouchTargets /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v PasswordSecurityState /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v IncludeRareChar /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\TabletTip\1.7" /v ScratchOutState /f >nul 2>&1

:: Restore TabletTip Auto-Invoke and Visibility
reg delete "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableDesktopModeAutoInvoke /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v EnableDesktopModePenAutoInvoke /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v LastTipXPositionOnScreen /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v TipbandDesiredVisibility /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v TipbandDesiredVisibilityTabletMode /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v TipPinnedToMonitor /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v TouchKeyboardTapInvoke /f >nul 2>&1

:: Restore Wisp Touch Physics and Delays
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v PanningDisabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Inertia /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Bouncing /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Friction /t REG_DWORD /d 50 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchModeN_DtapDist /t REG_DWORD /d 50 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchModeN_DtapTime /t REG_DWORD /d 50 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchGate /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchModeN_HoldTime_Animation /t REG_DWORD /d 50 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchModeN_HoldTime_BeforeAnimation /t REG_DWORD /d 50 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v TouchMode_hold /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Mobile_Inertia_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Minimum_Velocity /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Touch" /v Thumb_Flick_Enabled /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\MultiTouch" /v MultiTouchEnabled /t REG_DWORD /d 1 /f

:: Restore Wisp Pen Gestures and Processing
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v Splash /t REG_DWORD /d 50 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v DblDist /t REG_DWORD /d 50 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v DblTime /t REG_DWORD /d 300 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v TapTime /t REG_DWORD /d 100 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v WaitTime /t REG_DWORD /d 300 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v HoldTime /t REG_DWORD /d 2300 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v FlickMode /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v FlickTolerance /t REG_DWORD /d 50 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v Latency /t REG_DWORD /d 8 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v SampleTime /t REG_DWORD /d 8 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v UseHWTimeStamp /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v SguiMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v HoldMode /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v MouseInputResolutionX /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v MouseInputResolutionY /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v MouseInputFrequency /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v EraseEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v RightMaskEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters" /v Color /t REG_DWORD /d 3221225472 /f

:: Restore Hexadecimal Flick Commands
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v Left /t REG_BINARY /d 4846455758C338419F7145B888BB26B8 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v UpLeft /t REG_BINARY /d 47F38E42CEFA51BCEBDFECA56A8CB1AC /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v Up /t REG_BINARY /d 450285124653D9748090833CF6D41AA0 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v UpRight /t REG_BINARY /d 47F38E42CEFA51BC6A8CB1ACEBDFECA5 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v Right /t REG_BINARY /d C267B8DE4FA8068E4E301EF93B324FAB /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v DownRight /t REG_BINARY /d 47F38E42CEFA51BC6A8CB1ACEBDFECA5 /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v Down /t REG_BINARY /d 441A7051435776E6F7C82D37F0853D9B /f
reg add "HKCU\Software\Microsoft\Wisp\Pen\SysEventParameters\FlickCommands" /v DownLeft /t REG_BINARY /d 47F38E42CEFA51BCEBDFECA56A8CB1AC /f

:: Restore Tablet Mode and Immersive Shell Scaling
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TabletMode" /v STCDefaultMigrationCompleted /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v ExitedTabletModeWhileCSMActive /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletModeActivated /t REG_DWORD /d 0 /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletModeCoverWindow /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletModeInputHandler /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v AllowPPITabletModeExit /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell\OverrideScaling" /v SmallScreen /t REG_DWORD /d 83 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell\OverrideScaling" /v VerySmallScreen /t REG_DWORD /d 71 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell\OverrideScaling" /v TabletSmallScreen /t REG_DWORD /d 83 /f

echo Disable Touch, Pen, and Tablet UI Features restored successfully.

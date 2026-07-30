@echo off
title By Platinum+ Optimizer
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSch_QueueDepth" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSch_MaxPendingCommand" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSch_ThreadPriority" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DmaRemappingCompatible" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableVsyncLatencyUpdate" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableDirtyRectangles" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FrameQueueMode" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "FSE_Enable" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableWddm2Checks" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "PowerSettingEnable" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableAsyncPresentation" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "PlatformSupportMiracast" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "IommuUsage" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "D3D12DisableSharedDynamicValueManagement" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableMemoryEncryption" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "VerifyDriverLevel" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "MaxFrameLatency" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnableMultiPlaneOverlay3DDIs" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "ForceDirectFlip" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableOverlays" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HighPriorityCompletionMode" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "GpuPriorityChangeMode" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DCIControl" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\MemoryManagement" /v "DirectStorageForceFlush" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableComputePreemption" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "VsyncIdleTimeout" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableVsyncClockGroup" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "GpuPriority" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PreemptionLevel" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "MicrocodeQueuePriority" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableAsyncCompute" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableMidGfxPreemption" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableSCGMidBufferPreemption" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "SchedulePolicy" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "GpuResourceAccessPriority" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableYield" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnablePreemptiveScheduling" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "EnableCudaContextPreemption" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /v "PollStatusIterations" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "InvalidateDynamicPstate" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmGpsPsEnablePerCpuCoreDpc" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "RmDisableRegistryCaching" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "EnablePowerBudget" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "IgnoreBatteryVoltageSag" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Scheduler" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\MemoryManagement" /f
echo Restore General Optimize DXG Graphics Management applied successfully.

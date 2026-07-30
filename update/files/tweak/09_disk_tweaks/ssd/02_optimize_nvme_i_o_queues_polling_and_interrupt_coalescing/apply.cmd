@echo off
title By Platinum+ Optimizer

:: Optimize NVMe Queues, Interrupts, and Polling
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MaxTransferSize /t REG_MULTI_SZ /d "2048" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IoQueueDepth /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IoSubmissionQueueCount /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IoCompletionQueueCount /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v InterruptCoalescingTime /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v InterruptCoalescingEntry /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ArbitrationBurst /t REG_MULTI_SZ /d "255" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ReservedQueuePairCount /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IoQueuePercentageInPollingMode /t REG_MULTI_SZ /d "100" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IoPollingInterval /t REG_MULTI_SZ /d "100000" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IoCompletionCapInDPC /t REG_MULTI_SZ /d "128" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v IoPollingSize /t REG_MULTI_SZ /d "0x4000" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v MaxIoCountLimit /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v SubmissionQueueAssignmentPolicy /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v EnableSingleDpcForIoCompletion /t REG_MULTI_SZ /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v NumberOfRequests /t REG_MULTI_SZ /d "0" /f

echo Optimize NVMe I/O Queues, Polling, and Interrupt Coalescing applied successfully.

# Variables and Paths

$global:W = 1760

$global:H = 1040

$global:LogoPath = "$PSScriptRoot\..\ico\logo.png"

$global:AppIcon = "$PSScriptRoot\..\ico\platinum.ico"

$global:CpuIco = "$PSScriptRoot\..\ico\cpu.png"

$global:RamIco = "$PSScriptRoot\..\ico\ram.png"

$global:GpuIco = "$PSScriptRoot\..\ico\gpu.png"

$global:AboutIco = "$PSScriptRoot\..\ico\about.png"

$global:RegIco = "$PSScriptRoot\..\ico\registry.png"

$global:BackupIco = "$PSScriptRoot\..\ico\backup.png"

$global:RestoreIco = "$PSScriptRoot\..\ico\restore.png"

$global:BugIco = "$PSScriptRoot\..\ico\bug.png"

$global:DebloatIco = "$PSScriptRoot\..\ico\trash.png"

$global:ServiceIco = "$PSScriptRoot\..\ico\service.png"

$global:EthernetIco = "$PSScriptRoot\..\ico\ethernet_nav.png"

$global:EthernetTweakIco = "$PSScriptRoot\..\ico\ethernet1.png"

$global:DiskIco = "$PSScriptRoot\..\ico\disk.png"

$global:InputIco = "$PSScriptRoot\..\ico\input.png"

$global:DriverIco = "$PSScriptRoot\..\ico\box.png"

$global:GameIco = "$PSScriptRoot\..\ico\game.png"

$global:WindowsFixIco = "$PSScriptRoot\..\ico\windows.png"

$global:Wifi1Ico = "$PSScriptRoot\..\ico\wifi1.png"

$global:AppFixIco = "$PSScriptRoot\..\ico\app.png"

$global:GeneralIco = "$PSScriptRoot\..\ico\general.png"

$global:CustomizationIco = "$PSScriptRoot\..\ico\cust.png"

$global:AmdIco = "$PSScriptRoot\..\ico\amd.png"

$global:RadeonIco = "$PSScriptRoot\..\ico\radeon.png"

$global:IntelIco = "$PSScriptRoot\..\ico\intel.png"

$global:NvidiaIco = "$PSScriptRoot\..\ico\nvidia.png"

$global:Win10Ico = "$PSScriptRoot\..\ico\windows10.png"

$global:Win11Ico = "$PSScriptRoot\..\ico\windows11.png"

$global:WifiIco = "$PSScriptRoot\..\ico\wifi.png"

$global:NotificationIco = "$PSScriptRoot\..\ico\logo.jpg"

$global:SearchIco = "$PSScriptRoot\..\ico\search.png"

$global:WrenchIco = "$PSScriptRoot\..\ico\wrench.png"

$global:ChartIco = "$PSScriptRoot\..\ico\chart.png"

$global:SystemIco = "$PSScriptRoot\..\ico\system.png"

$global:BurntToastModulePath = "$PSScriptRoot\..\libs\BurntToast\BurntToast.psd1"

$global:BurntToastReady = $false

$global:AleDectIco = "$((Get-Item $PSScriptRoot).Parent.FullName)\ico\aledect.jpg".Replace("\\","/")

$global:StefanoIco = "$((Get-Item $PSScriptRoot).Parent.FullName)\ico\stefano.jpg".Replace("\\","/")

$global:GhIco = "$((Get-Item $PSScriptRoot).Parent.FullName)\ico\github.png".Replace("\\","/")

$global:TgIco = "$((Get-Item $PSScriptRoot).Parent.FullName)\ico\telegram.png".Replace("\\","/")

$global:KofiIco = "$((Get-Item $PSScriptRoot).Parent.FullName)\ico\kofi.png".Replace("\\","/")

$global:YoutubeIco = "$((Get-Item $PSScriptRoot).Parent.FullName)\ico\youtube.png".Replace("\\","/")

$global:DiscordIco = "$((Get-Item $PSScriptRoot).Parent.FullName)\ico\discord.png".Replace("\\","/")

$global:TikTokIco = "$((Get-Item $PSScriptRoot).Parent.FullName)\ico\tiktok.png".Replace("\\","/")

$global:MainLogo = "$((Get-Item $PSScriptRoot).Parent.FullName)\ico\logo.png".Replace("\\","/")

$global:HomeIco = "$PSScriptRoot\..\ico\home.png"

$global:GamesTabIco = "$PSScriptRoot\..\ico\game.png"

$global:LaunchersTabIco = "$PSScriptRoot\..\ico\box.png"

$global:GamePerfSearchIco = "$PSScriptRoot\..\ico\search.png"

$global:PerformanceIco = "$PSScriptRoot\..\ico\performance.png"

$global:ShieldIco = "$PSScriptRoot\..\ico\shield.png"

$global:LockIco = "$PSScriptRoot\..\ico\lock.png"

$global:BootIco = "$PSScriptRoot\..\ico\boot.png"

$global:PowerIco = "$PSScriptRoot\..\ico\power.png"

$global:PlugIco = "$PSScriptRoot\..\ico\plug.png"

$global:PrivacyIco = "$PSScriptRoot\..\ico\privacy.png"

$global:TelemetryIco = "$PSScriptRoot\..\ico\telemetry.png"

$global:BrushIco = "$PSScriptRoot\..\ico\brush.png"

$global:Wrench1Ico = "$PSScriptRoot\..\ico\wrench1.png"

$global:RegistryIco = "$PSScriptRoot\..\ico\registry.png"

$global:SoftwareTabIco = "$PSScriptRoot\..\ico\box.png"
$global:LaunchersTabIco = "$PSScriptRoot\..\ico\rocket.png"

$global:HomeIco = "$PSScriptRoot\..\ico\home.png"

$global:CheckIco = "$PSScriptRoot\..\ico\check.png"

$global:Check1Ico = "$PSScriptRoot\..\ico\check1.png"

$global:ErrorIco = "$PSScriptRoot\..\ico\error.png"

$global:AlertIco = "$PSScriptRoot\..\ico\alert.png"



# Initialize applied state variables
$global:appliedTweaks = @{}
$global:appliedCpuTweaks = @{}
$global:appliedGpuTweaks = @{}
$global:appliedRamTweaks = @{}
$global:appliedDiskTweaks = @{}
$global:appliedNetTweaks = @{}
$global:appliedInputTweaks = @{}

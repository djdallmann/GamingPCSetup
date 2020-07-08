# Basic example of using powershell to quickly modify Windows running state before and after playing a game
# e.g. Suspend processes, turn off windows defender, close explorer, and adjust timer resolution 
# then restore when done playing
#
# 1. Download proclist.xml and svclist.xml, edit if necessary or make your own. See how to in variable section.
# 2. Change path references in variables section to your proclist.xml and svclist.xml if used
# 3. Uncomment the desired both On and Off states GM-GameMode-On and GM-GameMode-Off
#    Note: For every enabled game mode state, the opposite should also be uncommented 
#          to restore previous operating state
# 4. Open Powershell as Administrator
# 5. Import-Module C:\PATHTO\gamemode.ps1
# 6. Use GM-GameMode-On to enable the desired settings
# 7. Use GM-GameMode-Off to restore previous state
# 8. Customize, rinse and repeat
#
# Author: djdallmann
# https://github.com/djdallmann/GamingPCSetup
# Happy Scripting :D

################
# Variables
################

$procpath = "C:\Users\ddallmann\Desktop\proclist.xml"
$svcpath = "C:\Users\ddallmann\Desktop\svclist.xml"
[System.Collections.ArrayList]$ProcessesList = Import-Clixml -Path $procpath
[System.Collections.ArrayList]$SvcList = Import-Clixml -Path $svcpath

# How To: Example of creating your own proclist.xml OR svclist.xml
# $ProcessesList = [System.Collections.ArrayList]::new()
# $ProcessesList.Add("steamwebhelper")
# $ProcessesList.Add("armsvc")
# $ProcessesList.Add("nvdisplay.container")
# $ProcessesList | Export-Clixml -Path C:\Users\ddallmann\Desktop\proclist.xml

#####################
# External DLL Imports
#####################
$MethodDefinition = @'
[DllImport("ntdll.dll", SetLastError=true)]
public static extern void NtSuspendProcess(IntPtr processHandle);

[DllImport("ntdll.dll", SetLastError=true)]
public static extern void NtResumeProcess(IntPtr processHandle);

[DllImport("ntdll.dll", SetLastError=true)]
public static extern NtStatus NtQueryTimerResolution(out uint MinimumResolution, out uint MaximumResolution, out uint ActualResolution);

[DllImport("ntdll.dll", SetLastError=true)]
public static extern int NtSetTimerResolution(int DesiredResolution, bool SetResolution, out int CurrentResolution );
'@

$NtStatus = Add-Type -MemberDefinition $MethodDefinition -Name 'NtStatus' -Namespace 'Win32' -PassThru


#####################
#     Functions
#####################

function GM-SuspendProcess-ByName($NamePattern) {
	$processes = ''
	$processes = Get-Process -Name "$NamePattern"

	Foreach ($i in $processes) {
		$ret = [Win32.NtStatus]::NtSuspendProcess($i.handle)
	}
}

function GM-ResumeProcess-ByName($NamePattern) {
	$processes = ''
	$processes = Get-Process -Name "$NamePattern"

	Foreach ($i in $processes) {
		$ret = [Win32.NtStatus]::NtResumeProcess($i.handle)
	}
}

function GM-ResumeProcessesInList($ProcNameList) {
	Foreach ($i in $ProcNameList) {
		Write-Host Resuming $i
		GM-ResumeProcess-ByName($i)
	}
}

function GM-SuspendProcessesInList($ProcNameList) {
	Foreach ($i in $ProcNameList) {
		Write-Host Suspending $i
		GM-SuspendProcess-ByName($i)
	}
}

function GM-StopServicesInList($ServiceList) {
	Foreach ($i in $ServiceList) {
		Write-Host Stopping service: $i
		Stop-Service -Name "$i"
	}
}

function GM-StartServicesInList($ServiceList) {
	Foreach ($i in $ServiceList) {
		Write-Host Starting service: $i
		Start-Service -Name "$i"
	}
}

function GM-ResumeProcessesNotInList($ProcNameList) {
	$curprocesses = Get-Process

	Foreach ($i in $curprocesses) {
		$proc = $i.ProcessName | Where-Object { $ProcNameList -Match $_ }
		If ($proc) {
			Write-Host Skipping $i.ProcessName
			continue
		} Else {
			Write-Host Resuming $i.ProcessName
			GM-ResumeProcess-ByName($i.ProcessName)
		}
	}
}

function GM-SuspendProcessesNotInList($ProcNameList) {
	$curprocesses = Get-Process

	Foreach ($i in $curprocesses) {
		$proc = $i.ProcessName | Where-Object { $ProcNameList -Match $_ }
		If ($proc) {
			#Write-Host Skipping $i.ProcessName
			continue
		} Else {
			Write-Host Suspending $i.ProcessName
			GM-SuspendProcess-ByName($i.ProcessName)
		}
	}
}

function GM-DisableRealtimeWinDefender() {
	#Only works with tamper protection off
	Set-MpPreference -DisableRealtimeMonitoring $true
	Write-Host Disabling Windows Defender Realtime Protection
}

function GM-EnableRealtimeWinDefender() {
	#Only works with tamper protection off
	Set-MpPreference -DisableRealtimeMonitoring $false
	Write-Host Enabling Windows Defender Realtime Protection
}

function GM-EnableIdle() {
	Write-Host PowerCFG Enable Idle
	C:\Windows\System32\powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 0
	C:\Windows\System32\powercfg -setactive scheme_current
}

function GM-DisableIdle() {
	Write-Host PowerCFG Disable Idle
	C:\Windows\System32\powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1
	C:\Windows\System32\powercfg -setactive scheme_current
}

function GM-QueryTimerResolution() {
	$ntqtrmin = $null
	$ntqtrmax = $null
	$ntqtrcur = $null
	
	[Win32.NtStatus]::NtQueryTimerResolution([ref]$ntqtrmin, [ref]$ntqtrmax, [ref]$ntqtrcur)
	Write-Host "Current Timer Res: $ntqtrcur `r`nTimer Res Minimum: $ntqtrmin `r`nTimer Res Maximum: $ntqtrmax"
}

function GM-SetTimerResolution($timerres) {
	if ($timerres -ge 4000) {
		#Set to 0.5ms e.g. 5000
		$ntdesiredres = $timerres
		$ntsetres = $true
		$ntcurrentres = 156250
		Write-Host Setting timer resolution to $timerres
		$ret1 = [Win32.NtStatus]::NtSetTimerResolution($ntdesiredres,$ntsetres,[ref]$ntcurrentres)
		GM-QueryTimerResolution
	}
}

function GM-ReleaseTimerResolution() {
	#Default 15ms
	$ntdesiredres = 156250
	$ntsetres = $true
	$ntcurrentres = 156250
	Write-Host Resetting timer resolution
	$ret1 = [Win32.NtStatus]::NtSetTimerResolution($ntdesiredres,$ntsetres,[ref]$ntcurrentres)
}

function GM-KillExplorer() {
	Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 0
	Stop-Process -Name "explorer" -Force
}

function GM-ReviveExplorer() {
	Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 1
	C:\Windows\explorer.exe
}

function GM-GameMode-On() {
	GM-SetTimerResolution(5000)
	GM-KillExplorer
	GM-DisableIdle
	GM-DisableRealtimeWinDefender
	GM-SuspendProcessesInList($ProcessesList)
	GM-StopServicesInList($SvcList)
}

function GM-GameMode-Off() {
	GM-ReleaseTimerResolution
	GM-ReviveExplorer
	GM-EnableIdle
	GM-EnableRealtimeWinDefender
	GM-ResumeProcessesInList($ProcessesList)
	GM-StartServicesInList($SvcList)
}
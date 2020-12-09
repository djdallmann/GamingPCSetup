# Basic example of using powershell to quickly modify Windows running state before and after playing a game
# e.g. Suspend processes, turn off windows defender, close explorer, and adjust timer resolution 
# then restore when done playing
#
# 1. Download procsuspendlist.xml, svcstoplist.xml and svcsuspendlist.xml, edit if necessary or make your own. See how to in variable section.
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

#####################
# Variables
#####################

# Referenced Variable Name: $ProcessesSuspendList
$ProcessesSuspendList = [System.Collections.ArrayList]::new()
$procsuspendpath = "C:\Users\ddallmann\Desktop\procsuspendlist.xml"

# Referenced Variable Name: $SvcStopList
$SvcStopList = [System.Collections.ArrayList]::new()
$svcstoppath = "C:\Users\ddallmann\Desktop\svcstoplist.xml"

# Referenced Variable Name: $SvcSuspendList
$SvcSuspendList = [System.Collections.ArrayList]::new()
$svcsuspendpath = "C:\Users\ddallmann\Desktop\svcsuspendlist.xml"

# How To: Example of creating your own list.xml
# $ProcessesList = [System.Collections.ArrayList]::new()
# $ProcessesList.Add("steamwebhelper")
# $ProcessesList.Add("armsvc")
# $ProcessesList.Add("nvdisplay.container")
# $ProcessesList | Export-Clixml -Path C:\Users\ddallmann\Desktop\proclist.xml

$global:taskschedpid = ''

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

[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool SetProcessWorkingSetSize(IntPtr hProcess, int dwMinimumWorkingSetSize, int dwMaximumWorkingSetSize);

[DllImport("Dwmapi.dll", SetLastError=true)]
public static extern int DwmEnableMMCSS(bool fEnableMMCSS);
'@

$NtStatus = Add-Type -MemberDefinition $MethodDefinition -Name 'NtStatus' -Namespace 'Win32' -PassThru


#####################
#     Functions
#####################

function GM-ImportExternalList($MyPath) {
	if (Test-Path -Path "$MyPath") {
		Write-Host Importing $MyPath
		return Import-Clixml -Path "$MyPath"
	} else {
		Write-Host "External list not found: $MyPath"
	}
}

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

function GM-SuspendProcess-ByPid($ProcID) {
	$process = Get-Process -Id "$ProcID"
	$ret = [Win32.NtStatus]::NtSuspendProcess($process.handle)
}

function GM-ResumeProcess-ByPid($ProcID) {
	$process = Get-Process -Id "$ProcID"
	$ret = [Win32.NtStatus]::NtResumeProcess($process.handle)
}

function GM-ResumeProcessesInList($ProcNameList) {
	if ($ProcNameList.Count -gt 1) {
		Foreach ($i in $ProcNameList) {
			Write-Host Resuming $i
			GM-ResumeProcess-ByName($i)
		}
	} else {
		Write-Host 'Resumed process count zero, no actions taken'
	}
}

function GM-SuspendProcessesInList($ProcNameList) {
	if ($ProcNameList.Count -gt 1) {
		Foreach ($i in $ProcNameList) {
			Write-Host Suspending $i
			GM-SuspendProcess-ByName($i)
		}
	} else {
		Write-Host 'Suspend process count zero, no actions taken'
	}
}

function GM-SuspendServicesInList($ServiceList) {
	$tasksched = $false

	if ($ServiceList.Count -gt 1) {
		if ($ServiceList.Contains("Schedule")) { $tasksched = $true }
			Foreach ($i in $ServiceList) {
				$procid = (get-wmiobject win32_service | where { $_.name -eq "$i"}).processID

				if ($i -eq "Schedule") { $global:taskschedpid = $procid; continue; }

				Write-Host Suspending service: $i
				GM-SuspendProcess-ByPid($procid)
			}
		if ($tasksched) {
			Write-Host Suspending service: Schedule
			GM-SuspendProcess-ByPid($global:taskschedpid)
		}
	} else {
		Write-Host 'Suspend service count zero, no actions taken'
	}
}

function GM-ResumeServicesInList($ServiceList) {
	if ($global:taskschedpid -ge 0) {
		Write-Host Resuming service: Schedule
		Write-Host NOTE: Suspending Task Scheduler will delay the resume process
		GM-ResumeProcess-ByPid($global:taskschedpid)
	}
	if ($ServiceList.Count -gt 1) {
		Foreach ($i in $ServiceList) {
			if ($i -eq "Schedule") { continue }
			$procid = (get-wmiobject win32_service | where { $_.name -eq "$i"}).processID
			Write-Host Resuming service: $i
			GM-ResumeProcess-ByPid($procid)
		}
	} else {
		Write-Host 'Resumed service count zero, no actions taken'
	}
}

function GM-StopServicesInList($ServiceList) {
	if ($ServiceList.Count -gt 1) {
		Foreach ($i in $ServiceList) {
			Write-Host Stopping service: $i
			Stop-Service -Name "$i"
		}
	} else {
		Write-Host 'Stop service count zero, no actions taken'
	}
}

function GM-StartServicesInList($ServiceList) {
	if ($ServiceList.Count -gt 1) {	
		Foreach ($i in $ServiceList) {
			Write-Host Starting service: $i
			Start-Service -Name "$i"
		}
	} else {
		Write-Host 'Start service count zero, no actions taken'
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

function GM-TrimWorkingSetAll() {
	$processes = Get-Process
	Foreach ($i in $processes) {
		if ($processes.handle) {
			$ret = [Win32.NtStatus]::SetProcessWorkingSetSize($processes[0].handle, -1, -1)
		}
	}
}

function GM-DwmEnableMMCSS([bool]$option) {
	#TRUE to instruct DWM to participate in MMCSS scheduling; FALSE to opt out or end participation in MMCSS scheduling.
	if ($option) {
		Write-Host Requesting that DWM participate in MMCSS scheduling
		$ret = [Win32.NtStatus]::DwmEnableMMCSS($option)
	} else {
		Write-Host "Requesting that DWM 'NOT' participate in MMCSS scheduling"
		$ret = [Win32.NtStatus]::DwmEnableMMCSS($option)
	}

	if ($ret -gt 0) {
		Write-Host DwmEnableMMCSS Enable Failed: $ret
	}
	#https://docs.microsoft.com/en-us/windows/win32/seccrypto/common-hresult-values
	#https://docs.microsoft.com/en-us/windows/win32/api/dwmapi/nf-dwmapi-dwmenablemmcss
}

function GM-SetWin32PrioritySeparation($decvalue) {
	Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name Win32PrioritySeparation -Value $decvalue
	#https://docs.microsoft.com/en-us/previous-versions//cc976120(v=technet.10)?redirectedfrom=MSDN
}

function GM-RestoreWin32PrioritySeparationProgramDefault() {
	Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl" -Name Win32PrioritySeparation -Value 2
	#https://docs.microsoft.com/en-us/previous-versions//cc976120(v=technet.10)?redirectedfrom=MSDN
}

function GM-GameMode-On() {
	#GM-SetTimerResolution(5000)
	GM-KillExplorer
	#GM-DisableIdle
	GM-DisableRealtimeWinDefender
	GM-SuspendProcessesInList($ProcessesSuspendList)
	GM-StopServicesInList($SvcStopList)
	GM-SuspendServicesInList($SvcSuspendList)
	#GM-SetWin32PrioritySeparation(2)
	GM-TrimWorkingSetAll
}

function GM-GameMode-Off() {
	#GM-ReleaseTimerResolution
	GM-ReviveExplorer
	#GM-EnableIdle
	GM-EnableRealtimeWinDefender
	GM-ResumeProcessesInList($ProcessesSuspendList)
	GM-StartServicesInList($SvcStopList)
	GM-ResumeServicesInList($SvcSuspendList)
	GM-RestoreWin32PrioritySeparationProgramDefault
}


#####################
# Imported Lists
#####################
$ProcessesSuspendList = GM-ImportExternalList($procsuspendpath)
$SvcStopList = GM-ImportExternalList($svcstoppath)
$SvcSuspendList = GM-ImportExternalList($svcsuspendpath)

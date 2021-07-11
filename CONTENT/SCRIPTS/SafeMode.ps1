# This SOFTWARE PRODUCT is provided by THE PROVIDER "as is" and "with all faults." 
# THE PROVIDER makes no representations or warranties of any kind concerning the safety, 
# suitability, inaccuracies, typographical errors, or other harmful components 
# of this SOFTWARE PRODUCT. There are inherent dangers in the use of any software, and you are 
# solely responsible for determining whether this SOFTWARE PRODUCT is compatible with your equipment 
# and other software installed on your equipment. You are also solely responsible for the protection 
# of your equipment and backup of your data, and THE PROVIDER will not be liable for any damages you 
# may suffer in connection with using, modifying, or distributing this SOFTWARE PRODUCT.
#
# Author: djdallmann
# https://github.com/djdallmann/GamingPCSetup
# 
# An exploratory tool for analyzing the service and driver dependencies of safeboot/safe mode. 
# The script will export running driver and service information in each state then compared. 
# This can be used to create a simlar operating state while booted normally, useful for troubleshooting 
# or to reduce the time to create a minimal build/installation using safemode  configuration state as 
# the baseline. The running system could be refined further with additional research. Disabling specific
# services or drivers can impact performance or normal operation, make incremental changes and test the impacts.
#
# Other operating state changes may also occur as part of booting into safe mode, this does not 
# capture all environmental state changes just drivers and services.
#
################
# Guided Mode
################
#
# 1. Download the script and place it in it's own folder .\Desktop\SafeMode\SafeMode.ps1
# 2. Set-ExecutionPolicy Unrestricted
# 3. Boot into safe mode and change directories to the folder you created earlier.
# 4. Run the command .\SafeMode.ps1 -Guided
# 5. Once it has run successfully and collected the necessary data boot into normal mode.
# 6. Run the command again (.\SafeMode.ps1 -Guided ) to collect the regular operational state data.
# 7. You will be prompted to disable related services which were present in the operating state but not
#    the safeboot operational state, if you choose n (no) you can review the operating state differences 
#    afterwards which have been exported to files. Once you have had time to review the changes and have
#    determined which services you'd like to disable run the scrip again to continue.
#
#    Note: If a driver/service isn't detected during the primary operational state it does not mean they 
#          won't be needed in the future by another service such as dependent of or dependencies.
#          Pay close attention to drivers start up type (boot, system, manual, automatic), depended on and
#          dependencies presented during the disabling services process.
#
#    SafeModeBaseServices.txt - A list of dependent services, drivers and driver groups (Base, File System, 
#                               and NDIS) required for safeboot with networking.
#
#                               HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network
#
#    NonSafeBootRunningServices.txt - A list of services running in normal mode that were not at the 
#                                     time of safemode data capture.
#
#    DisabledSvcActivityLog.txt - A text file created as part of the disabling services process, it logs the
#                                 date/time, the action outcome, and the previous start up type of the modified
#                                 driver and service for future reference (e.g. Manual, System, Automatic)

[CmdletBinding()]
Param(
	[Parameter(Mandatory=$false)]
	[switch]$Guided
)

$servicelist = Get-ChildItem -Path Registry::HKLM\SYSTEM\CurrentControlSet\Services\

function Export-ServiceConfiguration {
	$servicelist = Get-ChildItem -Path Registry::HKLM\SYSTEM\CurrentControlSet\Services\
	$servicelist | Export-Clixml -Path .\ServicesBaseConfig.xml
}

function Get-SafeBootKeys {
	$safeboottype = "Network"
	$reg_safebootsvclist = Get-ChildItem -Path Registry::HKLM\SYSTEM\CurrentControlSet\Control\SafeBoot\$($safeboottype)\
	return $reg_safebootsvclist
}

function Resolve-SafeBootKeyNames {
	$reg_safebootsvclist = Get-SafeBootKeys
	$driversgroups = Get-ChildItem -Path Registry::HKLM\SYSTEM\CurrentControlSet\Services\ | Get-ItemProperty -name Group -ErrorAction Ignore
	$safebootkeys = @()
	foreach ( $i in $reg_safebootsvclist ) {
		$type = ''
		$type = $i | Get-ItemProperty | Select-Object -ExpandProperty '(default)'

		if ( $type -eq "Service" ) {
			$safebootkeys += $i.PSChildName
			
		} elseif ( $type -eq "Driver" ) {
			$safebootkeys += $i.PSChildName -replace "\.sys",""
			
		} elseif ( $type -eq "Driver Group" ) {
			foreach ( $d in $driversgroups ) {
				$drivergrp = ''
				$drivergrp = $d.Group
				if ( $i.PSChildName -eq $drivergrp ) {
					$safebootkeys += $d.PSChildName
				}
			}
		}
	}
	return $safebootkeys
}

function Export-SafeBootDriverData {
	$bootstate = gwmi win32_computersystem | select BootupState

	if (( Test-Path -Path .\SafeModeSCQuery.xml -PathType leaf ) -and ( Test-Path -Path .\SafeModeDriverQuery.xml -PathType leaf )) {
		Write-Host "SafeMode Driver Data Already Exported e.g. SafeModeSCQuery.xml, SafeModeDriverQuery.xml"
	} elseif ( $bootstate.BootupState.Contains("Fail-safe") ) {
		#Get drivers state
		$sm_driverquery_driverlist = driverquery.exe -v /FO csv | ConvertFrom-Csv
		$sm_scexe_drivernamelist = sc.exe query type=all | findstr SERVICE_NAME | % {$_.replace("SERVICE_NAME: ","")}

		#Export safe mode objects
		$sm_driverquery_driverlist | Export-Clixml -Path .\SafeModeDriverQuery.xml
		$sm_scexe_drivernamelist | Export-Clixml -Path .\SafeModeSCQuery.xml
	}
}

function Get-SafeBootDriverQueryData {
	$sm_driverquery_driverlist = Import-Clixml -Path .\SafeModeDriverQuery.xml
	return $sm_driverquery_driverlist
}

function Get-SafeBootSCData {
	$sm_scexe_drivernamelist = Import-Clixml -Path .\SafeModeSCQuery.xml
	return $sm_scexe_drivernamelist
}

function Export-LiveDriverData {
	$driverquery_driverlist = driverquery.exe -v /FO csv | ConvertFrom-Csv
	$scexe_drivernamelist = sc.exe query type=all | findstr SERVICE_NAME | % {$_.replace("SERVICE_NAME: ","")}
	
	#Export safe mode objects
	$driverquery_driverlist | Export-Clixml -Path .\DriverQuery.xml
	$scexe_drivernamelist | Export-Clixml -Path .\SCQuery.xml
}

function Get-LiveDriverQueryData {
	$driverquery_driverlist = Import-Clixml -Path .\DriverQuery.xml
	return $driverquery_driverlist
}

function Get-LiveSCData {
	$scexe_drivernamelist = Import-Clixml -Path .\SCQuery.xml
	return $scexe_drivernamelist
}

function Compare-SCQueryDriverData {
	$sm_scexe_drivernamelist = Get-SafeBootSCData
	$scexe_drivernamelist = Get-LiveSCData
	
	$livesvccompare = Compare-Object -ReferenceObject $scexe_drivernamelist -DifferenceObject $sm_scexe_drivernamelist -IncludeEqual
	$livenotrunning = @()
	foreach ( $i in $livesvccompare ) {
		if ( $i.SideIndicator -eq "<=" ) {
			$livenotrunning += $i.InputObject
		}
	}
	return $livenotrunning
}

function Disable-NonSafeBootServices {
	foreach ( $i in $livenotrunning ) {
		$log = ''
		$svcinfo = Get-Service -Name $i
		Write-Host "$i -> $($svcinfo.DisplayName)"
		$dependency = $svcinfo.ServicesDependedOn
		Write-Host "Start Type: $($svcinfo.StartType)"
		Write-Host "Has dependencies: $($dependency.Name)"
		Write-Host "Other services depends?: $($svcinfo.DependentServices)"
		$answer = Read-Host -Prompt "Disable? y/n [y]"
		if ($answer -ne "n") {
			try {
				Set-Service -name $i -StartupType "Disable" -ErrorAction stop
				$log = "$(Get-Date) - Service $i - Disabled - Old StartType: $($svcinfo.StartType)"
				$log | Out-File -Append -FilePath .\DisabledSvcActivityLog.txt
			} catch {
				Write-Host "WARNING!! Could not disable, try alternative method. e.g. Registry, or services.msc"
				$log = "$(Get-Date) - Service $i - Couldn't disable service try another method. e.g. Registry, or services.msc"
				$log | Out-File -Append -FilePath .\DisabledSvcActivityLog.txt
			}
		} else {
			$log = "$(Get-Date) - Service $i - Unmodified"
			$log | Out-File -Append -FilePath .\DisabledSvcActivityLog.txt
		}
		Write-Host ""
		Write-Host ""
	}
}

if ($guided) {
	if ( -Not (Test-Path .\SafeModeSCQuery.xml -PathType leaf) ) {
		Write-Host "Exporting registry defaults from HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services"
		Export-ServiceConfiguration
		Write-Host "Configuration saved to .\ServicesBaseConfig.xml"
	}
	
	if ( -Not (Test-Path .\SafeModeServices.txt -PathType leaf) ) {
			Write-Host "Exporting minimum required SafeBoot with Networking drivers and services to .\SafeModeServices.txt"
			$safebootkeys = Resolve-SafeBootKeyNames
			$safebootkeys | Out-File -FilePath  .\SafeModeBaseServices.txt
	}

	$bootstate = gwmi win32_computersystem | select BootupState
	if ( -Not (Test-Path -Path .\SafeModeSCQuery.xml -PathType leaf ) -or -Not (Test-Path -Path .\SafeModeDriverQuery.xml -PathType leaf) ) {
		Write-Host "WARNING! Data missing, reboot into safe mode then re-run the script: .\SafeMode.ps1 -Guided"
		Write-Host "Safe Mode: Start Menu > Run > msconfig > Boot tab > Boot options > Select Safe boot then choose network > Press OK > Restart"

		if ( $bootstate.BootupState.Contains("Fail-safe") ) {
			Write-Host "Already in safe mode, capturing data."
			Export-SafeBootDriverData
			Write-Host "Disable SafeBoot and restart into your normal operating state then re-run the script: .\SafeMode.ps1 -Guided"
		}
	} elseif (( Test-Path -Path .\SafeModeSCQuery.xml -PathType leaf ) -and ( Test-Path -Path .\SafeModeDriverQuery.xml -PathType leaf )) {
		Write-Host "SafeMode driver data ready (SafeModeSCQuery.xml, SafeModeDriverQuery.xml)"
	
		if ( $bootstate.BootupState.Contains("Fail-safe") ) {
			Write-Host "Still in safe mode, disable SafeBoot and restart into your normal operating state then re-run the script: .\SafeMode.ps1 -Guided"
		} else {
			Write-Host "Exporting normal operating driver state."
			Export-LiveDriverData
			
			Write-Host "Loading saved data from normal mode and safemode."
			Write-Host "Comparing service and driver data of normal mode and safemode."
			$livenotrunning = Compare-SCQueryDriverData
			$livenotrunning | Out-File -FilePath .\NonSafeBootRunningServices.txt
			Write-Host "Data ready!!"
			Write-Host ""
			Write-Host "######################"
			Write-Host "WARNING!!! Continue at your own risk, choose n to exit and review data more closely."
			Write-Host "######################"
			Write-Host ""
			$answer = Read-Host -Prompt "Process differences and incrementally start disabling? y/n [n]"
			if ($answer -eq "y") {
				Write-Host ""
				Disable-NonSafeBootServices
				Write-Host "A copy of service changes can be found here X"
				Write-Host "Restart your PC to the changes to take full effect"
			}
			Write-Host ""
			Write-Host ""
			Write-Host "######################"
			Write-Host "See generated files for further research or comparison:" 
			Write-Host "######################"
			Write-Host "SafeModeBaseServices.txt - A list of dependent services, drivers and driver groups required for safeboot with networking."
			Write-Host "NonSafeBootRunningServices.txt - A list of services running in normal mode that were not at the time of safemode data capture."
		}
	}
}
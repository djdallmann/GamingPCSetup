#
# Not intended to be anything special just quick and dirty
# Author: https://github.com/djdallmann/GamingPCSetup
# Date: 2022-01-27

$global:SubGroup=''
$global:SubGroupGUID=''
$global:SubGroupName=''
$global:PowerSettingGUID=''
$global:PowerSettingName=''
$global:CurAC=''
$global:CurDC=''

$powerplanlist = powercfg -list
$powerplans = @{}

foreach ($plan in $powerplanlist) {
	if ($plan -match '(\w+-\w+-\w+-\w+-\w+)\s+\((.*?)\)') {
		$powerplans.Add($matches[1], $matches[2])
		$filename = "$($matches[1]).txt"
		powercfg /setactive $matches[1]
		powercfg /QH > "$filename"
	}
}

Write-Output "PowerPlanGUID,PowerPlanName,SugGroup,SubGroupGUID,PowerSettingGUID,PowerSettingName,CurAcVal,CurDCVal"

foreach ( $plan in $powerplans.GetEnumerator() ) {
	$result = Get-Content -Path .\"$($plan.Name).txt"
	$global:SubGroup=''
	$global:SubGroupGUID=''
	$global:PowerSettingGUID=''
	$global:PowerSettingName=''
	$global:CurAC=''
	$global:CurDC=''

	foreach ($ln in $result) {
		if ( $ln -match 'Subgroup GUID:\s+(\w+-\w+-\w+-\w+-\w+)\s+\((.*?)\)' ) {
			$global:SubGroup=$matches[1]
			$global:SubGroupGUID=$matches[2]
		} elseif ( $ln -match 'Power Setting GUID:\s+(\w+-\w+-\w+-\w+-\w+)\s+\((.*?)\)' ) {
			$global:PowerSettingGUID=$matches[1]
			$global:PowerSettingName=$matches[2]
		} elseif ( $ln -match 'Current AC Power Setting Index:\s(\S+)' ) {
			$global:CurAC=$matches[1]
		} elseif ( $ln -match 'Current DC Power Setting Index:\s(\S+)' ) {
			$global:CurDC=$matches[1]
		} elseif ($ln -match '^$') {
			Write-Output "$($plan.Name),$($plan.Value),$SubGroup,$SubGroupGUID,$PowerSettingGUID,$PowerSettingName,$CurAC,$CurDC"
		}
	}
}
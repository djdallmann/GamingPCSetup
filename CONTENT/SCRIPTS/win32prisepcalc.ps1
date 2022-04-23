for ($i=0; $i -le 271; $i++) {

$w32prisepbin = [Convert]::ToString($i,2).padleft(6, '0')
$w32prisepbin = $w32prisepbin[-6..-1]
$w32prisepinterval = ''
$w32priseptime = ''
$w32prisepboost = ''
$qrvforeground = ''
$qrvbackground = ''

#INTERVAL
if (($w32prisepbin[0,1] -join'' -eq '11') -or ($w32prisepbin[0,1] -join'' -eq '00')) {
	$w32prisepinterval = 'Shorter'
} elseif ($w32prisepbin[0,1] -join'' -eq '01') {
	$w32prisepinterval = 'Longer'
} elseif ($w32prisepbin[0,1] -join'' -eq '10') {
	$w32prisepinterval = 'Shorter'
}
#TIME
if (($w32prisepbin[2,3] -join'' -eq '11') -or ($w32prisepbin[2,3] -join'' -eq '00')) {
	$w32priseptime = 'Variable'
} elseif ($w32prisepbin[2,3] -join'' -eq '01') {
	$w32priseptime = 'Variable'
} elseif ($w32prisepbin[2,3] -join'' -eq '10') {
	$w32priseptime = 'Fixed'
}
#FGBOOST
if (($w32prisepbin[4,5] -join'' -eq '10') -or ($w32prisepbin[4,5] -join'' -eq '11')) {
	$w32prisepboost = '3:1'
} elseif ($w32prisepbin[4,5] -join'' -eq '00') {
	$w32prisepboost = 'Equal and Fixed'
} elseif ($w32prisepbin[4,5] -join'' -eq '01') {
	$w32prisepboost = '2:1'
}

if ($w32priseptime -eq 'Fixed') {
	if ($w32prisepinterval -eq 'Longer') {
		$qrvforeground = 36
		$qrvbackground = 36
	} else {
		$qrvforeground = 18
		$qrvbackground = 18
	}
} else {
	if ($w32prisepinterval -eq 'Longer') {
		if ($w32prisepboost -eq '3:1') {
			$qrvforeground = 36
			$qrvbackground = 12
		} elseif ($w32prisepboost -eq '2:1') {
			$qrvforeground = 24
			$qrvbackground = 12
		} else {
			$qrvforeground = 12
			$qrvbackground = 12
		}
	} else {
		if ($w32prisepboost -eq '3:1') {
			$qrvforeground = 18
			$qrvbackground = 6
		} elseif ($w32prisepboost -eq '2:1') {
			$qrvforeground = 12
			$qrvbackground = 6
		} else {
			$qrvforeground = 6
			$qrvbackground = 6
		}
	}
}

Write-Output "$($i),0x$($i.ToString("X")),$w32prisepinterval,$w32priseptime,$qrvforeground,$qrvbackground"

}
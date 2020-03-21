#########
# Collect Information about DPC and ISR using xperf
#########
#Update paths before using
#Run once to collect the data, run again to stop and generate report.

$fLocation = "D:\PerfMon\xperfstate.txt"

if (Test-Path $fLocation) {
    $TSTATE = import-clixml -path $fLocation
} else {
    $TSTATE = "OFF"
    $TSTATE | export-clixml -path $fLocation
}

if ( $TSTATE -eq "ON" ) {
	$date = date
	xperf -d "D:\PerfMon\trace.etl"
	xperf -i D:\PerfMon\trace.etl -o "D:\PerfMon\$($date.ToString("yyyyMMdd-hhmm")).txt" -a dpcisr
	$TSTATE = "OFF"
    $TSTATE | export-clixml -path $fLocation
} else {
	xperf.exe -on base+interrupt+dpc
	$TSTATE = "ON"
    $TSTATE | export-clixml -path $fLocation
}

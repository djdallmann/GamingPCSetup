#########
# Collect Information about DPC and ISR using xperf
#########
#Update paths before using
#Once the script is run it'll sleep for 5 seconds so you can switch 
#to your game or application then it records for 30 seconds.
#Adjust to best suite your conditions or scenario

$date = date
Start-Sleep -s 5
xperf -on Latency -stackwalk profile -BufferSize 1024
write-host "Started"
Start-Sleep -s 30
xperf -d "D:\PerfMon\trace.etl"
xperf -i D:\PerfMon\trace.etl -o "D:\PerfMon\$($date.ToString("yyyyMMdd-hhmm")).txt" -a dpcisr

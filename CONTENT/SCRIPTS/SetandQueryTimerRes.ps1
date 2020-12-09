# Basic example of using powershell for setting or querying the windows timer resolution value 
# using .NET functions by importing the ntdll.dll functions NtSetTimerResolution, NtQueryTimerResolution
#
# You can use this function to micro-increment timer resolution 
# See https://github.com/djdallmann/GamingPCSetup/blob/master/RESEARCH/FINDINGS/timermicroadjust.txt
#
# Author: djdallmann
# https://github.com/djdallmann/GamingPCSetup
# Happy Scripting :D

$ntqtrmin = $null
$ntqtrmax = $null
$ntqtrcur = $null

#The resolution you want
$ntdesiredres = 6000
$ntsetres = $true
$ntcurrentres = 156250

#Import the functions from dll
$MethodDefinition = @’
[DllImport("ntdll.dll", SetLastError=true)]
public static extern NtStatus NtQueryTimerResolution(out uint MinimumResolution, out uint MaximumResolution, out uint ActualResolution);

[DllImport("ntdll.dll", SetLastError=true)]
public static extern int NtSetTimerResolution(int DesiredResolution, bool SetResolution, out int CurrentResolution );
‘@
$NtStatus = Add-Type -MemberDefinition $MethodDefinition -Name 'NtStatus' -Namespace 'Win32' -PassThru

#Set the timer resolution using the variables at the top
$ret1 = [Win32.NtStatus]::NtSetTimerResolution($ntdesiredres,$ntsetres,[ref]$ntcurrentres)

#Query the timer resolution and store them in the variables ntqtrmin, ntqtrmax and ntqtrcur
[Win32.NtStatus]::NtQueryTimerResolution([ref]$ntqtrmin, [ref]$ntqtrmax, [ref]$ntqtrcur)

#Print the timer resolution values
Write-Host "Current Timer Res: $ntqtrcur `r`nTimer Res Minimum: $ntqtrmin `r`nTimer Res Maximum: $ntqtrmax `r`n"

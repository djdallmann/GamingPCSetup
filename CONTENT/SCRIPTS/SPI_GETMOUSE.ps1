#
# Monitor windows mouse attributes as it relates to mouse acceleration and speed
# using SystemParametersInfo API and SPI_GETMOUSE
# https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-systemparametersinfow
#
# Useful for seeing how these values change with different games settings (launch options)
# during in-game menus.
#
# Example in thread below, mixed results in CSGO with different options.
# https://forums.blurbusters.com/viewtopic.php?t=9769#p78837
#
# Source: https://github.com/djdallmann/GamingPCSetup
# 

Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;

namespace MouseThings
{
    public class Mouse {
        [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
            private static extern int SystemParametersInfo(
                int uAction, 
                int uParm, 
                int[] lpvParam, 
                int fuWinIni);

        private const int SPI_GETMOUSE = 0x0003;
        private const int SPI_GETMOUSEHOVERHEIGHT = 0x0064;
        private const int SPI_GETMOUSEHOVERTIME = 0x0066;
        private const int SPI_GETMOUSEHOVERWIDTH = 0x0062;
        private const int SPI_GETMOUSESPEED = 0x0070;
        private const int SPI_GETMOUSETRAILS = 0x005E;
        private const int SPI_GETMOUSEWHEELROUTING = 0x201C;

        public int[] spiGetMouse() {
            int[] res = new int[3];
            SystemParametersInfo(SPI_GETMOUSE, 0, res, 0);
            return res;
        }
    }
}

"@

$mouse = New-Object MouseThings.Mouse

while($true) {
	$result = $mouse.spiGetMouse()
	write-host "MouseThreshold1:" $result[0] "- MouseThreshold2:" $result[1] "- MouseSpeed:" $result[2]
	sleep 2
}
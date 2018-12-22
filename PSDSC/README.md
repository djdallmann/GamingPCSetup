## Powershell Desired State Configuration (DSC) Scipt Overview
The Powershell DSC script focuses on the following:
- A human readable and customizable script
- A way of validating your system state before testing after initial Desired State Configuration (DSC) is applied
- Disabling any unecessary services, it will impact Local Network File Transfers (CIFS/SMB), Printing and Scanning, Bluetooth Device and Communication
- Disables most if not all Windows 10 features and privacy/tracking settings, interfering Windows Update settings (P2P sharing)
- Sets Mousespeed to 6/11 (Middle of slider bar in mouse settings)
- Disables Enhanced Pointer Precision
- Sets Power Profile to High Performance, Disables Usb Selective Suspend
- Sets Windows Advanced Settings to 'Adjust for Best Performance', disables desktop visual features
- Disables Fastboot from inside Windows Power Settings
- Disables GameBar, GameMode, GameDVR, Audio/Game Capture Settings
- Disables Remote Assistance/Desktop
- Disables all Ease of Access features that could impact keyboard or mouse interactions
- Disables Cortana
- Disables all mouse gestures, hand writing, keyboard spelling and auto correction features
- Disables automatic sample submission uploads for Windows Defender

See the desired state configuration script for a complete list of changes.

## Setup
1. Download the GamingMinimal.ps1 Powershell DSC Script to your desktop
2. Edit GamingMinimal.ps1 script and replace ```$myusername = "ddallmann"``` with your Windows user account name
   - e.g. $myusername = "johndoe"
3. Save the file
4. Open Powershell as an administrator
5. Change the directory to your desktop where you saved the file
   - ```PS C:\Windows\system32> cd C:\Users\johndoe\Desktop```
6. Run the command ```PS C:\Users\johndoe\Desktop> Set-ExecutionPolicy Unrestricted``` Type/Press Y and then Enter to accept, this will allow the script to run
7. Run the command ```PS C:\Users\johndoe\Desktop> .\GamingMinimal.ps1```, this will build the configuration state file
8. Start the Windows Remote Management Service (This is necessary for DSC to work)
   - ```PS C:\Users\johndoe\Desktop> Start-Service -name WinRM```
9. Apply the optimized configuration to your local computer, wait for it to complete.
   - ```PS C:\Users\johndoe\Desktop> Start-DscConfiguration -Path .\GamingMinimal\ -wait -verbose```
   - The first pass might give one or two errors (red), these will go away after restart
10. Restart your PC and **redo steps 4, 8 and 9.**

## Testing your computers desired state configuration
1. Open Powershell as an administrator
2. Make sure Windows Remote Management Service is started (should be started automatically but slightly delayed after a reboot)
   - ```PS C:\Windows\system32> Start-Service -name WinRM```
3. Run ```PS C:\Windows\system32> Test-DscConfiguration```
4. If it matches it'll say **True**, if it doesn't it'll say **False**
   - For more details run ```PS C:\Windows\system32> Test-DscConfiguration -Detailed```
   - Sometimes you have to wait a minute to run the command if the DSC is being applied behind the scenes automatically after a restart.
5. For the most part the configuration should always match (be **True**) if all other steps were followed in this guide, you can always re-apply the configuration at anytime for example after a Windows Update.

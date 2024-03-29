## PowerShell Desired State Configuration (DSC) Scipt Overview
The PowerShell DSC script focuses on the following:
- A human readable and customizable script
- A way of validating your system state before testing after initial Desired State Configuration (DSC) is applied
- Disabling any unecessary services, it will impact Printing and Scanning, Bluetooth Device and Communication
- Disables most if not all Windows 10 features and privacy/tracking settings, interfering Windows Update settings (P2P sharing)
- High Performance power profile, USB selective suspend
- Sets Windows Advanced Settings to 'Adjust for Best Performance', disables desktop visual features
- Disables GameBar, GameMode, GameDVR, Audio/Game Capture Settings

For a complete list see [DSC Itemized Configuration List](ConfigList.md)

## Setup
1. Download the GamingMinimal.ps1 PowerShell DSC Script to your desktop
   - [GamingMinimal.ps1](GamingMinimal.ps1)
2. Open Windows PowerShell as an administrator
3. Change the directory to your desktop where you saved the file
   - ```PS C:\Windows\system32> cd ~\Desktop```
4. Run the command ```PS C:\Users\johndoe\Desktop> Set-ExecutionPolicy Unrestricted -Force```, this will allow the script to run
5. Run the command ```PS C:\Users\johndoe\Desktop> .\GamingMinimal.ps1 -myusername "your_windows_username"```, this will build the configuration state file
6. Start the Windows Remote Management Service (This is necessary for DSC to work)
   - ```PS C:\Users\johndoe\Desktop> Start-Service -name WinRM```
7. Apply the optimized configuration to your local computer, wait for it to complete.
   - ```PS C:\Users\johndoe\Desktop> Start-DscConfiguration -Path .\GamingMinimal\ -wait -verbose```
   - The first pass might give one or two errors (red), these will go away after restart
8. Restart your PC and **redo steps 2, 6 and 7.**

## Testing your computers desired state configuration
1. Open Windows PowerShell as an administrator
2. Make sure Windows Remote Management Service is started (should be started automatically but slightly delayed after a reboot)
   - ```PS C:\Windows\system32> Start-Service -name WinRM```
3. Run ```PS C:\Windows\system32> Test-DscConfiguration```
4. If it matches it'll say **True**, if it doesn't it'll say **False**
   - For more details run ```PS C:\Windows\system32> Test-DscConfiguration -Detailed```
   - Sometimes you have to wait a minute to run the command if the DSC is being applied behind the scenes automatically after a restart.
5. For the most part the configuration should always match (be **True**) if all other steps were followed in this guide, you can always re-apply the configuration at anytime for example after a Windows Update.

**Note:** You can **force apply the DSC configuration** using the following command **if for some reason it hasn't applied all changes and says False**, or if you've edited the DSC script and rebuilt the localhost.mof database.
```Start-DscConfiguration -Path .\GamingMinimal\ -wait -verbose -force```

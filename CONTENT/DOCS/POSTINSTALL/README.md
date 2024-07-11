## Post Installation Steps

1. In **Windows Device Manager** (devmgmt.msc) go to **Network adapters** and right click each and go to properties, then Power Management and **uncheck Allow the computer to turn off this device to save power**.
2. Disable NetBIOS over TCP in Network Adapter IPV4 settings to disable unnecessary SYSTEM listening service
   * **Network & Internet Settings > Change Adapter Options > Adapter Properties > Select TCP/IP v4 > Advanced > WINS tab > Disable NetBIOS over TCP/IP > Press OK**
   * Note: This change is immediate
3. Right click the desktop and go to Display Settings, ensure that Scale and layout are set to 100% (Recommended)
4. **Add exclusions to Windows Defender**
   - Open **Windows Security** and go to **Virus and Threat Protection > Virus and Threat Protection Settings > Exclusions** and be sure to add each of your games as as **full paths to the executable** vs just using executable name to ensure ideal security with least impact during gameplay. e.g. *D:\Steam Games\steamapps\common\Half-Life\hl.exe vs just hl.exe*
   - Open Powershell as admin and enter the following command to add scanning exclusions for the Steam, NVIDIA Shader Cache folder and Microsoft's recommendations for exclusions to Windows Defender. See [Technical References](../../TECHNICAL%20REFERENCES/README.md) for more information on Microsoft's recommendations.
   - This will help reduce the time spent scanning by Windows Defender as new files are downloaded and those used during gameplay (e.g. textures, sounds).

      ```
      Add-MpPreference -ExclusionPath $env:LOCALAPPDATA"\Temp\NVIDIA Corporation\NV_Cache"
      Add-MpPreference -ExclusionPath $env:PROGRAMDATA"\NVIDIA Corporation\NV_Cache"
      Add-MpPreference -ExclusionPath $env:LOCALAPPDATA"\AMD\DX9Cache"
      Add-MpPreference -ExclusionPath $env:LOCALAPPDATA"\AMD\DxCache"
      Add-MpPreference -ExclusionPath $env:LOCALAPPDATA"\AMD\DxcCache"
      Add-MpPreference -ExclusionPath $env:LOCALAPPDATA"\AMD\OglCache"
      Add-MpPreference -ExclusionPath $env:windir"\SoftwareDistribution\Datastore\Datastore.edb"
      Add-MpPreference -ExclusionPath $env:windir"\SoftwareDistribution\Datastore\Logs\Edb*.jrs"
      Add-MpPreference -ExclusionPath $env:windir"\SoftwareDistribution\Datastore\Logs\Edb.chk"
      Add-MpPreference -ExclusionPath $env:windir"\SoftwareDistribution\Datastore\Logs\Tmp.edb"
      Add-MpPreference -ExclusionPath $env:windir"\SoftwareDistribution\Datastore\Logs\*.log"
      Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.edb"
      Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.sdb"
      Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.log"
      Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.chk"
      Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.jrs"
      Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.xml"
      Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.csv"
      Add-MpPreference -ExclusionPath $env:windir"\Security\Database\*.cmtx"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\GroupPolicy\Machine\Registry.pol"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\GroupPolicy\Machine\Registry.tmp"
      Add-MpPreference -ExclusionPath $env:userprofile"\NTUser.dat"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\sru\*.log"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\sru\*.dat"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\sru\*.chk"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\Configuration\MetaConfig.mof"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\winevt\Logs\*.evtx"
      Add-MpPreference -ExclusionPath $env:windir"\apppatch\sysmain.sdb"
      Add-MpPreference -ExclusionPath $env:windir"\EventLog\Data\lastalive?.dat"
      Add-MpPreference -ExclusionProcess ${env:ProgramFiles(x86)}"\Windows Kits\10\Windows Performance Toolkit\WPRUI.exe"
      Add-MpPreference -ExclusionProcess ${env:ProgramFiles(x86)}"\Windows Kits\10\Windows Performance Toolkit\wpa.exe"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\WindowsPowerShell\v1.0\Modules"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\Configuration\DSCStatusHistory.mof"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\Configuration\DSCEngineCache.mof"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\Configuration\DSCResourceStateCache.mof"
      Add-MpPreference -ExclusionPath $env:SystemRoot"\System32\Configuration\ConfigurationStatus"
      Add-MpPreference -ExclusionProcess ${env:ProgramFiles(x86)}"\Common Files\Steam\SteamService.exe"
      ```

5. Uninstall common Windows Store Metro Apps, In Powershell as admin run the following commands and press enter so they complete.

      ```
      Get-AppxPackage *print3d* | Remove-AppxPackage
      Get-AppxPackage *3dviewer* | Remove-AppxPackage
      Get-AppxPackage *zune* | Remove-AppxPackage
      Get-AppxPackage *minecraft* | Remove-AppxPackage
      Get-AppxPackage *bing* | Remove-AppxPackage
      Get-AppxPackage *skype* | Remove-AppxPackage
      Get-AppxPackage *solitaire* | Remove-AppxPackage
      Get-AppxPackage *candycrush* | Remove-AppxPackage
      Get-AppxPackage *netflix* | Remove-AppxPackage
      Get-AppxPackage *onenote* | Remove-AppxPackage
      Get-AppxPackage *dolby* | Remove-AppxPackage
      Get-AppxPackage *fitbit* | Remove-AppxPackage
      Get-AppxPackage *feedback* | Remove-AppxPackage
      Get-AppxPackage *yourphone* | Remove-AppxPackage
      ```

6. Open CMD.exe (Command Prompt) as administrator and run this command to uninstall Microsoft OneDrive
`%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall`
7. Install any necessary drivers such as Chipset drivers provided by your manufacturer for your motherboard. **(Not videocard drivers, this will be done later)**
   - Check Windows Device Manager for clues as to which drivers may not be present or working, devices under System generally refer to Chipset or Management Systems (Intel Management Engine)
   - It is often recommended to use the drivers provided by your motherboard manufacturer since they may include additional optimizations for your specific hardware.
   - For the most part you may not need to install the latest audio or network drivers unless you notice issues with them in the future. The drivers that windows installs automatically are generally well tested or approved.
8. Avoid installing any uncessary software
9. Run **Process Idle Tasks** then while it's running open task manager and monitor the progress. The CPU, disk and memory use will increase for a few minutes until all the necessary background, scheduled and maintenenace tasks are complete.

      ```
      Open cmd.exe as administrator then enter the following command
      Rundll32.exe advapi32.dll,ProcessIdleTasks
      ```

10. **Don't modify Windows BOOT options using BCDEDIT.exe**, although they have the **potential** to alter your computing experience they are intended for advanced software debugging. The default BOOT options are recommended by Microsoft.
11. If you have an SSD ensure TRIM is enabled and run regularly, TRIM allows proper maintenance of unused space on SSDs after files have been deleted.
    - Check and enable TRIM windows feature, use the following commands using cmd.exe as administrator to check if the feature is enabled. It should return Disabled (0) if the feature is active.
         
         ```
         fsutil behavior query Disabledeletenotify
         fsutil behavior set DisableDeleteNotify 0
         ```
       
    - Increase the frequency TRIM is run for your SSD drive
      - Open My Computer
      - Right click your drive (e.g. C:) and go to properties, go to the Tools tab then Optimize
      - Press Change Settings, ensure Scheduled Optimization is enabled and set to **Daily** for each of your drives
      - Press the Drives button to double check each drive is specified for maintenance
      - Press OK/Apply for each of the open windows to submit the changes.
12. Optimize NTFS file system parameters to reduce updates to some of the metadata that is tracked.
    - Disable additional updates to directory last access times
    - Disables the creation of legacy 8.3 character-length file names on FAT- and NTFS-formatted volumes.
    
         ```
         Run the following commands using cmd.exe as administrator, requires restart to take effect
         fsutil behavior set disableLastAccess 1
         fsutil behavior set disable8dot3 1
         ```
13. Enable the Ultimate Performance power scheme which is intended to be an improved version of the High Performance power scheme.
    * As per [Technical References](../../TECHNICAL%20REFERENCES/README.md), *This new policy builds on the current High-Performance policy, and it goes a step further to eliminate micro-latencies associated with fine grained power management techniques.*
    * Remember **if you use the provided Desired State Configuration (DSC)** script with this guide and plan to use the new power scheme, **you'll need to edit the DSC to enforce the new ultimate performance power scheme** vs the high performance power scheme.
         ```
         Run the following commands using cmd.exe as administrator
         powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
         Go to Windows power options and enable Ultimate Performance power plan.
         ```
14. Core Parking (Windows 11 and later)
    * Starting with Windows 11 all built-in power plans have core parking enabled by default including the High Performance and Ultimate Performance power plans.
    * Setting Core Parking Min Cores value to 100% will disable Windows core parking algorithm, this can be configured for both P-Cores (CPMINCORES) and E-Cores (CPMINCORES1).
    * Windows 11 has many scheduler optimizations such as those used with Intel Thread Director, these settings may influence those optimizations.
         ```
         Run the following commands using cmd.exe as administrator to disable core parking on the current power plan.
         powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100
         powercfg -setacvalueindex scheme_current sub_processor CPMINCORES1 100
         powercfg -setactive scheme_current
         ```
15. Disable Windows Updates
    * Registry change below will stop windows from downloading and installing new updates, it also prevents forced updates after X days (paused updates).
      * This sets a custom Windows Server Update Services (WSUS) configuration to null value, so it always returns "up to date" and disables store automatic app updates.
      * This is more ideal than trying to disable all the windows update services (wuaserv, waasmedicsvc, usosvc etc) and scheduled tasks that restore windows update services.
      * Reference: https://learn.microsoft.com/en-us/windows/iot/iot-enterprise/soft-real-time/soft-real-time-device
    ```
    Windows Registry Editor Version 5.00

    [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
    "ExcludeWUDriversInQualityUpdate"=dword:00000001
    "DoNotConnectToWindowsUpdateInternetLocations"=dword:00000001
    "DisableWindowsUpdateAccess"=dword:00000001
    "WUServer"=" "
    "WUStatusServer"=" "
    "UpdateServiceUrlAlternate"=" "

    [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]
    "UseWUServer"=dword:00000001

    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate]
    "AutoDownload"=dword:00000002
    ```
    Use this to disable both automatic driver updates and windows updates [disableautomaticupdates.reg](disableautomaticupdates.reg)
16. Disable Automatic Driver Downloads and Updates
    * This is useful if you want absolute control of your installed drivers, windows will silently install and change drivers unless you're paying very close attention to the Windows Updates summary which adds variables to testing, benchmarks and experience.
    * Some of the most notable being AMD and Nvidia video drivers, you'll also see attempts to install new mouse HID drivers and their CoInstallers (Razer etc). Please note device drivers can be updated without CoInstallers (e.g. Razer Synapse) being installed, evidence in Device Manager in Human Interface Device entries.
    ```
    Windows Registry Editor Version 5.00
    
    ;Disable windows updates driver searching, control installation of drivers
    [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DriverSearching]
    "DriverUpdateWizardWuSearchEnabled"=dword:00000000

    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching]
    "SearchOrderConfig"=dword:00000000

    [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
    "ExcludeWUDriversInQualityUpdate"=dword:00000001
    
    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata]
    "PreventDeviceMetadataFromNetwork"=dword:00000001
    ```
    Use this to disable both automatic driver updates and windows updates [disableautomaticupdates.reg](disableautomaticupdates.reg)
17. Disable Co-Installers (Optional, recommended to disabled automatic driver updates instead)
    * Disables the Windows plug and play feature that performs additional software installation processes when a new device is connected to your computer. The most common example of this Razer Synapse setup starting when you connect a new device.
    * Having this feature disabled will prevent Windows from loading software like Razer Synapse _even if it was already added to your system through automatic updates_, to prevent this software from being automatically downloaded in the first place disable automatic driver downloads and updates before connecting your computer to the internet.
    * Disabling this feature may prevent legitimate software and drivers from being loaded when plugging in other types of devices such as printers and audio playback devices.
    ```
    Windows Registry Editor Version 5.00

    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Installer]
    "DisableCoInstallers"=dword:00000001
    ```
18. Restart your computer to ensure all settings are applied.
19. Reconnect your network ethernet cable, continue onto the next process.

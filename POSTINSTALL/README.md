These are additional steps not covered by the PowerShell Desired State Configuration (DSC).
## Post Installation Steps

1. In **Windows Device Manager** (devmgmt.msc) go to Universal Serial Bus controllers and right click each Host Controller and/or Hub and go to properties, then Power Management and 
**uncheck Allow the computer to turn off this device to save power**. 
2. Repeat this step for your **Network adapters** as well.
3. Right click the desktop and go to Display Settings, ensure that Scale and layout are set to 100% (Recommended)
4. Open Powershell as admin and enter the following command to add scanning exclusions for the Steam and NVIDIA Shader Cache folder to Windows Defender. 
   - This will prevent Windows Defender from scanning your games as they download files and during gameplay, **if you store your games on separate drives** ensure to add that path here as well.

      ```
      Add-MpPreference -ExclusionPath "C:\Program Files (x86)\Steam\"
      Add-MpPreference -ExclusionPath $env:LOCALAPPDATA"\Temp\NVIDIA Corporation\NV_Cache"
      ```

5. Uninstall common Windows Store Metro Apps, In Powershell as admin run the following commands and press enter so they complete.

      ```
      Get-AppxPackage *print3d* | Remove-AppxPackage
      Get-AppxPackage *3dviewer* | Remove-AppxPackage
      Get-AppxPackage *zune* | Remove-AppxPackage
      Get-AppxPackage *minecraft* | Remove-AppxPackage
      Get-AppxPackage *bing* | Remove-AppxPackage
      Get-AppxPackage *xboxapp* | Remove-AppxPackage
      Get-AppxPackage *skype* | Remove-AppxPackage
      Get-AppxPackage *solitaire* | Remove-AppxPackage
      Get-AppxPackage *candycrush* | Remove-AppxPackage
      Get-AppxPackage *netflix* | Remove-AppxPackage
      Get-AppxPackage *onenote* | Remove-AppxPackage
      Get-AppxPackage *dolby* | Remove-AppxPackage
      Get-AppxPackage *fitbit* | Remove-AppxPackage
      Get-AppxPackage *feedback* | Remove-AppxPackage
      Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage
      Get-AppxPackage *yourphone* | Remove-AppxPackage
      ```

6. Open CMD.exe (Command Prompt) as administrator and run this command to uninstall Microsoft OneDrive
`%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall`
7. Install any necessary drivers such as Chipset drives provided by your manufacturer for your motherboard. **(Not videocard drivers, this will be done later)**
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
      - Press Change Settings, ensure Scheduled Optimization is enabled and set to *Daily* for each of your drives
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
         
13. Reconnect your network ethernet cable, continue onto the next process.

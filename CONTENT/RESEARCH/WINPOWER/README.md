## Windows Power Settings
### Power Plans
#### Q: What are the differences between the Windows Power Plans and their hidden settings?
The best way is to compare for yourself, there are several power plan management tools available for download online. I've also provided a basic powershell script that will switch between each power plan then export the data in a CSV format using Windows built-in power management tool powercfg.exe, see below for more information.

A complete list of default values extracted from built-in power plans on Windows 10 2019 LTSC:
* [PowerPlanSettingsCompare.csv](../FINDINGS/PowerPlanSettingsCompare.csv)

A script that enumerates all power plan settings and exports it to CSV:
* [PowerPlantoCSV.ps1](../../SCRIPTS/PowerPlantoCSV.ps1)

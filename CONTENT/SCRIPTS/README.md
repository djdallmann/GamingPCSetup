## Miscellaneous Scripts

### [xperfdpcisr.ps1](xperfdpcisr.ps1)
  * A powershell script designed to help easily capture xperf data on DPC and ISR and then generate an xperf report.
### [SetandQueryTimerRes.ps1](SetandQueryTimerRes.ps1)
  * A powershell script that imports the native dll functions from ntdll.dll to both set and query the timer resolution.
### [GameMode.ps1](GameMode.ps1)
  * Basic example of using powershell to quickly modify Windows running state before and after playing a game e.g. Suspend processes, stop services, turn off windows defender realtime detection, close explorer, and adjust timer resolution and then restore the regular operating state when done. See file contents for instructions.
### [SafeMode.ps1](SafeMode.ps1)
  * An exploratory tool for analyzing the service and driver dependencies of safeboot/safe mode. The script will export running driver and service information in each state then compared. This can be used to create a simlar operating state while booted normally, useful for troubleshooting or to reduce the time to create a minimal build/installation using safemode configuration state as the baseline. The running system could be refined further with additional research. Disabling specific services or drivers can impact performance or normal operation, make incremental changes and test the impacts.
  * See script comments for instructions and guidance.

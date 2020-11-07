## Windows Registry
### Registry Keys and Values
#### Q: Is there an easy way to see what registry keys are accessed or modified by every process or dll upon execution or during runtime?
#### A: Yes, there are two relatively easy methods to check for this activity, Windows Sysinternals Process Monitor and Windows Performance Analyzer and Recorder. Windows Sysinternals Process Monitor is best used during realtime analysis, launching a process or restarting a service whereas Windows Performance Analyzer and Recorder also allows you to capture key information during the boot process.

<details><summary>Findings and Analysis</summary>

**Process Monitor**
1. Download Process Monitor - https://docs.microsoft.com/en-us/sysinternals/downloads/procmon
2. **Run as admin** and **press OK** to apply the default filter
3. In the navigation bar ensure that only **Show Registry Activity** button is selected.
![ProcessMonitorShowRegistryActivity](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/ProcessMonitorShowRegistryActivity.png)
4. Use the filtering options **Filter Menu -> Filter -> Add** to narrow down on the process of interest then **press OK**. You can also filter on the type of Registry I/O activity once you have a better idea of what you're looking for.
![ProcessMonitorFilterbyProcessName](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/ProcessMonitorFilterbyProcessName2.png)

**Windows Performance Analyzer and Recorder**
1. Download Windows Assessment and Deployment Kit (Windows ADK) - https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install
2. Only **install Windows Performance Analyzer** toolset
3. Open Windows Performance Recorder, select **Performance Scenario: Boot**, or if you want to capture a realtime snapshot then just choose memory or disk. Memory is preferred for short lived performance recording scenarios and disk for longer recording sessions.
4. Expand **Resource Analysis** then ensure to select **Registry I/O Activity** and **if ready, press Start**
![WindowsPerformanceRecorderRegistryBootProcess](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/WindowsPerformanceRecorderRegistryBootProcess.png)
5. Once the restart process is complete **use Windows Performance Analyzer to review the recorded information**, use the builtin filtering options to limit by process or registry paths.

</details>

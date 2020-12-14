## Windows Kernel
### Hardware Abstraction Layer (HAL)
#### Q: What information does the Windows HAL Event Provider capture when you change different bcdedit settings such as useplatformclock and useplatformtick in combination with the High Precision Event Timer (HPET) setting in the BIOS? What are the default values on/off vs undefined? Does the bcdedit tscsyncpolicy change the outcome in the event audit?
There's a few findings in the results which are dependant on the HPET being on vs off in the BIOS e.g. **VpptPhysicalTimer, Perf Counter**, what you may also notice is that the source CPU source isn't always the same but during the est. ~50 runs I performed it was primarily linked to one cpu core. 

The values **MaxComputedSpread** and **MaxWaves** I assume have to do with the **TSC calibration process** which determines an ideal value during runtime. A similar process can be seen in the [ReactOS project codebase under HAL](https://github.com/reactos/reactos/blob/2e1aeb12dfd8b44b4b57d377b59ef347dfe3386e/hal/halx86/apic/tsc.c). The tscsyncpolicy did not have any notable impact on the details in the event audit capture, it's possible it may affect MaxComputedSpread and MaxWaves but it is unclear without more information.

As for the default values **on/off vs undefined** I assume these are the same across similar CPU architectures and chipsets so your mileage may vary, I'm currently using an Intel I7 6700k on H270M. See findings and analysis for more details.

<details><summary>Findings and Analysis</summary>
  
When comparing undefined vs off/in for both userplatformclock and useplatformtick, **undefined was the same as FALSE**.
  
To reduce the size of the table below, the following column values did not change during any of the tests:
  * **AlwaysOnTimer**: 0
  * **AlwaysOnCounter**: 15
  * **Watchdog**: 0
  * **AuxCounter**: 15
 
**Column abbreviations**
  * **UPC:** useplatformclock - **UPT:** useplatformtick - **DDT:** disabledynamictick
  
| HPET BIOS | UPC | UPT | DDT | Clock Timer | CPU* | Perf Counter | Vppt Physical Timer | CPU | Tsc Adjust Avail | Max Computed Spread* | Max Waves* |
| ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| **TRUE** | UNDEF | UNDEF | UNDEF | 7 | 7 | 5 | 0 | 7 | 1 | 6,28,29,39 | 5,2 |
| **TRUE** | **TRUE** | UNDEF | UNDEF | 7 | 7 | 3 | 0 | NOTSC | NOTSC | NOTSC | NOTSC | 
| **TRUE** | UNDEF | **TRUE** | UNDEF | 12 | 7 | 5 | 3 | 7 | 1 | 27,44,32 | 2,3,4 | 
| **TRUE** | UNDEF | UNDEF | **TRUE** | 7 | 7,0 | 5 | 0 | 7 | 1 | 10,11,23 | 2,2,2 |
| **TRUE** | **TRUE** | **TRUE** | UNDEF | 12 | 7 | 3 | 3 | NOTSC | NOTSC | NOTSC | NOTSC | 
| **TRUE** | **TRUE** | UNDEF | **TRUE** | 7 | 7 | 3 | 0 | NOTSC | NOTSC | NOTSC | NOTSC |  
| **TRUE** | UNDEF | **TRUE** | **TRUE** | 12 | 7 | 5 | 3 | 7 | 1 | 4 | 3 | 
| **TRUE** | **TRUE** | **TRUE** | **TRUE** | 12 | 7 | 3 | 3 | NOTSC | NOTSC | NOTSC | NOTSC |
| **FALSE** | UNDEF | UNDEF | UNDEF | 7 | 7 | 5 | 0 | 7 | 1 | 34,50 | 3,2,6 |
| **FALSE** | **TRUE** | UNDEF | UNDEF | 7 | 7 | 1 | 0 | NOTSC | NOTSC | NOTSC | NOTSC |
| **FALSE** | UNDEF | **TRUE** | UNDEF | 12 | 7 | 5 | 2 | 7 | 1 | 16| 3 |
| **FALSE** | UNDEF | UNDEF | **TRUE** | 7 | 7 | 5 | 0 | 7 | 1 | 29 | 6 |
| **FALSE** | **TRUE** | **TRUE** | UNDEF | 12 | 0 | 1 | 2 | NOTSC | NOTSC | NOTSC | NOTSC |
| **FALSE** | **TRUE** | UNDEF | **TRUE** | 7 | 2 | 1 | 0 | NOTSC | NOTSC | NOTSC | NOTSC |
| **FALSE** | UNDEF | **TRUE** | **TRUE** | 7 | 7 | 5 | 0 | 7 | 1 | 12 | 4 |
| **FALSE** | **TRUE** | **TRUE** | **TRUE** | 12 | 7 | 1 | 2 | NOTSC | NOTSC | NOTSC | NOTSC |

**Note:** CPU, Max Computed Spread and Max Waves values may change on every reboot so a few were given as examples.

</details></br>

### Win32PrioritySeparation
#### Q: If you modify Win32PrioritySeparation (process foreground and background quantum lengths) in the registry does it update in realtime or does it require a system restart?
It updates in realtime which can be confirmed using WinDBG via Live Kernel debug

<details><summary>Findings and Analysis</summary>

* Using bcdedit you can enable debug mode which will allow you to use WinDBG in a more realtime debug mode. Once enabled and hooked you can read information about different processes and threads that are running including some of the operating systems global user and kernel space variables.
1. In a kernel hooked WinDBG use the following commands to show the current values for priority separation and foreground quantum length. This should match the equivalent number format in the registry value and the Quantum Values mapping for the related bitmask.
   * ```dd PsPrioritySeperation l1```
   * ```db PspForegroundQuantum l3```
2. Change the process context or get context of a specific process by listing processes and showing formation for that process, see references for .process.
   ```
   .process
   Implicit process is now 85b32d90
   lkd> dt _KPROCESS 85b32d90
   nt!_KPROCESS
   [...]
   +0x000 Header           : _DISPATCHER_HEADER
   +0x05c Affinity         : 3
   +0x060 DisableBoost     : 0y0
   +0x060 DisableQuantum   : 0y0
   +0x064 BasePriority     : 8 ''
   +0x065 QuantumReset     : 6 ''
   
   Note: Use     !process 0 0     to list all processes
   ```
3. Now change the win32priorityseparation value in the registry, then compare the results for the command above. Based on the return values it looks as if the base priority is a dynamic pointer reference and should adapt immediately, e.g. **quantum reset** aswell accordingly.

![Win32PrioritySeparation Quantum Unit Mapping](../../DOCS/IMAGES/Quantum%20Units%20Mapping.PNG)

XLSX File: [Win32PrioritySeparation Quantum Unit Mapping](../FINDINGS/Win32PrioritySeparation%20Quantum%20Unit%20Mapping.xlsx)

* Related references and citation:
  * https://docs.microsoft.com/en-us/previous-versions//cc976120(v=technet.10)?redirectedfrom=MSDN
  * https://www.microsoftpressstore.com/articles/article.aspx?p=2233328&seqNum=7
  * https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/-process--set-process-context-
  * https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/dt--display-type-
  * https://blogs.msdn.microsoft.com/embedded/2006/02/20/know-thy-tick/
</details></br>

### Timer Resolution
#### Q: Can you micro-increment/adjust the windows timer resolution?
Yes, but it isn't always consistent see findings for more information.

<details><summary>Findings and Analysis</summary>

* Using a programmatic loop of the Windows Kernel functions for setting and returning the value of the current windows timer resolution you can see that the result isn't always set to what was requested and sometimes reverts to a lower previous value.
* One aspect to this would be to see if there are any benefits of doing this if applications are analyzed at a lower level.
```
ntdll.dll 
- NtQueryTimerResolution
- NtSetTimerResolution
```
* See results:
[timermicroadjust.txt](../FINDINGS/timermicroadjust.txt)
</details></br>

#### Q: Can you monitor which programs requested specific timer resolutions over a period of time?
Yes, there are a few ways to monitor these requests here are two common methods, powercfg.exe energy report and a Windows Performance Recorder power usage resource analysis capture. See findings and analysis for the procedures.
<details><summary>Findings and Analysis</summary>
    
1. The **PowerCfg tool** built into windows has many functions, one of those is the energy report which will monitor the PC over a period of time and report any issues related to power consumption, timer resolution being one of those factors which changes the behavior of the computer which increases power consumption.
    1. Open cmd.exe or powershell.exe as an administrator
    2. Change your working directory, or use the output file path parameter to specify the location of the report.
    3. Run **powercfg.exe /energy** and wait for it to complete (60 sec by default)
    4. Look for sections with the following heading **Platform Timer Resolution:Outstanding Timer Request** for more information on the timer resolution requested and the associated processes.
2. Using **Windows Performance Recorder and Analyzer** which is part of the Windows Assessment and Deployment Kit, you can use the following instructions to capture long running information on power usage and information on timer resolution requests for that period of time.
    1. Download and install windows performance analyzer  if you haven't already.
       * https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install
    2. Open Windows Performance Recorder, **untick all and then select Power Usage** then press Start and let run until the monitoring period is satisfied then press Stop.
    3. Save the recording
    4. Open the recording in Windows Performance Analyzer
    5. Expand the **Power section** then scrol down to the bottom and expand the **Timer Resolution section** then double click **Timer Resolution Requests** to load the information.
    6. Review and analyze the displayed information, more notably the **Process** column and associated column **Resolution (us)**.
</details></br>

### Keyboard DPC and Interrupt Latency (PS/2 VS USB)
#### Q: Does PS/2 keyboard driver provide lower DPC latency than USB keyboard driver?
No, not during the tests I performed but PS/2 keyboard driver latency was more stable.

<details><summary>Findings and Analysis</summary>

* Based on 20 tests results of each PS/2 and USB it was noted that USB keyboard driver generally has lower DPC latency (~4-8 microseconds), however PS/2 overall is ultra consistent at 8 microsecond times 97-99% of the time. The test performed was a 5 second timer to alt-tab ingame then starts a 30 second sleep timer after xperf data capture is started, in-game I only held a single key for the entire duration. Not necessarily a real world test but a test that is relatively consistent/repeatable.

* PS/2 interrupt latency is around 32 microseconds consistently, I'm using **Message Signaled Interrupts** for the USB controller so likely why it didn't show any results for the opposing side. Will see if I can look into that.

* See results:
[KeyboardDPCandInterruptLatency-PS2vsUSB.txt](../FINDINGS/KeyboardDPCandInterruptLatency-PS2vsUSB.txt)
</details></br>

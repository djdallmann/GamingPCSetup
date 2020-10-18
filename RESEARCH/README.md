# Research

This section contains different areas of research, performance impacts of various settings, tackling common misconceptions and just good to know information.
If you do use this or redistribute this in any way, please give due credit.

## Peripherals
### Mouse Sensor Lens
#### Q: Should you clean your mouse sensor lens regularly, at what frequency and what cleaning methods are recommended?
#### A: Yes, you should try to clear any debris not only from the lens but the tracking surface itself regularly to reduce the likelihood of such particles affecting the sensors capability to track accurately. Cleaning methods should be those simlar to those of camera sensors and lens. See findings and analysis for more information.
<details><summary>Findings and Analysis</summary>
    
* If you use a fabric tracking surface there is a higher liklihood it has many particles, fibers, hair or other substances which can then be transfered onto your mouse sensor lens. 
* The assumed primary causes of such particles getting onto the lens are directly correlated to the conditions of the environment such as air circulation and filtration, rate at which these particles build up, those found directly on the tracking surface, the type of fabric, and the density of weave and threads.

**Observations: (See image sequences below)**
  * Particles build up relatively quick if the tracking surface is not cleaned prior to the lens.
  * The microscopic debris is not easily identifiable by sight, using a lint roller over the surface can greatly reduce the amount of particles which remain on the cloth tracking surface prior to cleaning lens.
  * The particle debris built up over a 1 week period was minimal and had limited impact on user perceived tracking ability.
  * Initial lens cleaning methods used included very gentle use of a cotton swab to loosen some debris followed by 1-2 shots of compressed air to achieve a clean sensor lens.

**Mouse Lens Particle Analysis - 1 days use without prior cleaning of the tracking surface**
![Mouse Lens - Particle Analysis - 1 Day Use Comparison.png](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/Mouse%20Lens%20-%20Particle%20Analysis%20-%201%20Day%20Use%20Comparison.png)

**Mouse Lens Particle Analysis - Build over 1 week, prior cleaning of both tracking surface and lens**
![Mouse Lens - Particle Analysis - Cleaning and Build Up Over Time.png](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/Mouse%20Lens%20-%20Particle%20Analysis%20-%20Cleaning%20and%20Build%20Up%20Over%20Time.png)

**Tracking Surface Particle Removal via Generic Lint Roller**
![Mousepad - HyperX Fury S XXL - Lint Roller Particle Removal.png](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/Mousepad%20-%20HyperX%20Fury%20S%20XXL%20-%20Lint%20Roller%20Particle%20Removal.png)

**Recommendations**
  * To clean the mouse sensor lens you would want to use an air dust blower like those used on cameras which should not produce any moisture unlike cans of compressed air, and a lens/sensor brush which would be less likely to scratch the plastic or glass lens.
  * Cleaning weekly or every two weeks after the initial tracking surface and lens would probably be sufficient as maintenance to ensure consistent performance overtime.
  * Use a mildly adhesive lint roller to remove smaller debris and particles prior to cleaning the mouse sensor lens.
  * You can purchase an Illuminated Jewelers Eye Loupe with approximately 40-60x zoom which is affordable, portable and functional to observe the conditions of your mousepad or mouse sensor lens.

</details>

### Mouse Lift Off Distance (LOD)
#### Q: Does the mouse LOD affect tracking on different surfaces, and do wear patterns also influence tracking with the same LOD?
#### A: The LOD may have positive or negative influence on mouse tracking, users experience, type of surface and its particulates will also influence the sensors capability to track movement accurately.
<details><summary>Findings and Analysis</summary>
    
* The lift of distance (LOD) of a mouse refers to the distance in which the sensor will register input from its surface, and usually measured in millimeters.
* The most common benefits of a low LOD is to reduce unwanted tracking when a user briefly lifts the peripheral off the tracking surface and respositions it in an existing area which is preferred or in preparation for the next intended gesture.
  * Users that tend to have lower sensitivity where their preferred application sensitivity and the use case (game/application) require them to reposition their mouse frequently  prefer a lower lift off distance throughout the session. 
  * Likewise a user with a higher sensitivity may be less likely to resposition their mouse dependent on their play style, techniques and the use case. A higher sensitivity would reduce the amount of physical movement required to cover the same distance in the application.

**Mousepad - HyperX Fury S XXL - Wear**
* The area circled in blue in the image below represents a common wear pattern from repeated casual gaming use (slightly over 1 years time) and is likely a combination of degradation of the mouse surface due to friction, temperature, transfer of skincells or material from the peripheral, mouse skates or plastic.
![Mousepad - HyperX Fury S XXL - Wear](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/Mousepad%20-%20HyperX%20Fury%20S%20XXL%20-%20Wear.JPG)

**Microscopic image of the fabric consistency**
![Mousepad - HyperX Fury S XXL - Micro - Wear Comparison](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/Mousepad%20-%20HyperX%20Fury%20S%20XXL%20-%20Micro%20-%20Wear%20Comparison.png)

**Demo: How does LOD affect sensor tracking over degraded fabric surfaces?**
* As a demonstration I've selected a brand new Razer Viper Mini (Model:RZ01-0325, Firmware: 1.03, Polling: 1000hz) to demonstrate how the sensors LOD calibration setting reacts to the surface and the area of wear on the HyperX Fury S XXL.
  * Video: https://www.youtube.com/watch?v=A1u5M7Cn4ik
  * **Observations:**
    * There is minimal impact to mouse tracking on less used areas with both low and high LOD calibration
    * Tracking across common wear patterns (although visually negligable) with a low LOD has a signficant impact on mouse tracking.
    * Using a higher LOD to accomodate for the tracking issues on worn area provides a more consistent user experience except the concerns with higher LOD itself, although there may be a very subtle difference in tracking when the sensor is transitioning between both worn and less used surface areas.

**Recommendations for tracking on fabric surfaces**
  * Ensure your surface is consistent and level for optimal tracking
  * For cloth mousepads, you may be able to increase the consistency of the surface by washing your mousepad with a mild detergent on target areas, see if others with your mousepad have done similar with success.
  * Not all surfaces may be compatible with your mouses sensor LOD calibration, and not all mice have a wide range of LOD calibration settings which could result in a poor user experience depending on the surface.
  * Test regularly for tracking inconsistencies, compare slightly worn areas to less used areas.
  * Particles on the mouse sensor lens may also impact your tests and observations, consult with or see your manufacturers guidelines for cleaning your sensors lens.

</details>

## Network
### Intel Interrupt Moderation
#### Q: Does interrupt moderation rate have an effect on deferred procedure call (DPC) or interrupt service routine (ISR) latency, and what are the key differences between each of the settings?
#### A: Yes, during the simulations it was found that it had more of an impact on DPC latency processing times over ISR, however each setting didn't scale equally as higher interrupt moderation values were used however this may be dependant other factors such as RSS, RSS affinity, rx/tx buffers, and timer resolution and the traffic simulation itself.

<details><summary>Findings and Analysis</summary>

**Configuration during the tests**
  * Tools: xperf & iperf
  * Windows 10 1909
  * PCI-E Network Adapter (Intel Gigabit Desktop CT)
  * Driver: Microsoft, 2018-06-12, 12.17.10.8
  * MSI Mode
  * RSS Enabled, 2 RSS on cores 3 & 4, NUMAStatic
  * RX & TX buffer 768
  * Adapter Power Savings Off
  * Default Timer Resolution: 15.6ms
  * 30sec simulation +900Mbps, TCP, 100MB transfers, no fragmentation

**Interrupts and DPC stats by mode**

**Extreme = 92,000**
  * Avg NDIS DPC Performance
  * 22% <= 8 usecs
  * 46% <= 16 usecs
  * 20% <= 32 usecs

**High = 115,000**
  * Avg NDIS DPC Performance
  * 2% <= 1 usecs
  * 7% <= 2 usecs
  * 31% <= 8 usecs
  * 46% <= 16 usecs
  * 11% <= 32 usecs

**Medium = 180,000**
  * Avg NDIS DPC Performance
  * 30% <= 1 usecs
  * 22% <= 4 usecs
  * 34% <= 16 usecs

**Adaptive = 200,000**
  * Avg NDIS DPC Performance
  * 6% <= 1 usecs
  * 22% <= 2 usecs
  * 41% <= 4 usecs
  * 24% <= 16 usecs

**Low = 340,000**
  * Avg NDIS DPC Performance
  * 23% <= 2 usecs
  * 55% <= 8 usecs

**Minimal = 640,000**
  * Avg NDIS DPC Performance
  * 49% <= 2 usecs
  * 8% <= 4 usecs
  * 34% <= 8 usecs

**Off (but Interrupt Moderation Enabled) = 2,650,000**
  * Avg NDIS DPC Performance
  * 27% <= 1 usecs
  * 58% <= 2 usecs
  * 8% <= 8 usecs

**Observations**
  * Interrupt Moderation Disabled produced the same numbers as with **Enabled but Off**
  * NDIS dpc latency spread (across cores) isn't always equally balanced between runs
but DPC latency performance does not change regardless
  * DPC latency in general is consistent between runs
  * The gap between Off and the next least restrictive setting (minimal) is very significant
  * The proper ordering of these settings from **least to most** interrupt requests are:
    * Extreme > High > Medium > Adaptive (Also dependent on load) > Low > Minimal > Off/Disabled
  * Overall **Medium** seemed to have the least impact on user experience/gaming while still providing low DPC latency. A very low DPC latency can still be achieved with a medium interrupt moderation value in which DPCs are processed 90% equal to or below 1 usecs for high volume small packet UDP communications (gaming).
</details>

### NetworkThrottlingIndex
#### Q: Disabling NetworkThrottlingIndex feature improves overall network performance and latency
#### A: Not completely true, NDIS.sys DPC latency is increased quite notably when disabled.

<details><summary>Findings and Analysis</summary>

* A very common recommendation in many performance enhancement/gaming guides state that disabling *NetworkThrottleIndex* improves network performance and latency because in theory it should prevent rate limiting and quality of service (QoS) interactions. 
* The main purpose of NetworkThrottlingIndex is to reduce (rate limit) calls which would otherwise impact real time audio and perhaps cause stutter or other audible artifacts.
* Disabling it may increase **throughput** should the throughput exceed the default receiving packets per millisecond (ppms) limit (NetworkThrottleIndex: 10 decimal, 10 packets per millisecond, 10,000 received packets per second which is roughly ~ 15Mbps with 1500byte Ethernet MTU) but it does not improve DPC latency which is probably more beneficial for lower latency applications such as video games.
* It's unclear why DPC processing latency is much lower when this feature is enabled even when you're not reaching the inbound receive rate limit in comparison to disabling the feature completely which removes any throttling.
* To learn mouse about Network Throttling Index see the [Technical References](../Technical%20References/README.md) article **Multimedia Class Scheduler Service (MMCSS) Vista Multimedia Playback and Network Throughput** written by Mark Russinovich.

* You can test this for yourself using **xperf**, start a capture for **dpcisr** and compare the results of both for **NDIS.sys**. 
* **Registry Path:** 
```
    HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\NetworkThrottlingIndex
    Off: DWORD Value 0xFFFFFFFF (Hex)
    On: DWORD Value 10 (Decimal), Default - Range: Decimal 1-70
``` 

  * You should see a similar result as below during load such as gameplay. **Note:** **Intel** tends to be closer to **<= 1-2 usecs (microseconds)** where as **Realtek** is much higher, around with some around **<= 32 usecs** and **most <= 4 usecs** when most network optimizations are applied.
  
  * **Intel**
    * **Disabled**, 0xFFFFFFFF
    
    ![NetworkThrottlingIndex Disabled](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/NDIS.sys%20-%20Intel%20-%20DPC%20Latency%20Unoptimized.png)
    * **Enabled**, Decimal 10
    
    ![NetworkThrottlingIndex Enabled](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/NDIS.sys%20-%20Intel%20-%20DPC%20Latency%20Optimized.png)
    
</details>

## Windows Kernel
### Win32PrioritySeparation
#### Q: If you modify Win32PrioritySeparation (process foreground and background quantum lengths) in the registry does it update in realtime or does it require a system restart?
#### A: It updates in realtime which can be confirmed using WinDBG via Live Kernel debug

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

![Win32PrioritySeparation Quantum Unit Mapping](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/Quantum%20Units%20Mapping.PNG)

XLSX File: [Win32PrioritySeparation Quantum Unit Mapping](https://github.com/djdallmann/GamingPCSetup/blob/master/RESEARCH/FINDINGS/Win32PrioritySeparation%20Quantum%20Unit%20Mapping.xlsx)

* Related references and citation:
  * https://docs.microsoft.com/en-us/previous-versions//cc976120(v=technet.10)?redirectedfrom=MSDN
  * https://www.microsoftpressstore.com/articles/article.aspx?p=2233328&seqNum=7
  * https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/-process--set-process-context-
  * https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/dt--display-type-
  * https://blogs.msdn.microsoft.com/embedded/2006/02/20/know-thy-tick/
</details>

### Timer Resolution
#### Q: Can you micro-increment/adjust the windows timer resolution?
#### A: Yes, but it isn't always consistent see findings for more information.

<details><summary>Findings and Analysis</summary>

* Using a programmatic loop of the Windows Kernel functions for setting and returning the value of the current windows timer resolution you can see that the result isn't always set to what was requested and sometimes reverts to a lower previous value.
* One aspect to this would be to see if there are any benefits of doing this if applications are analyzed at a lower level.
```
ntdll.dll 
- NtQueryTimerResolution
- NtSetTimerResolution
```
* See results:
[timermicroadjust.txt](https://github.com/djdallmann/GamingPCSetup/blob/master/RESEARCH/FINDINGS/timermicroadjust.txt)
</details>

#### Q: Can you monitor which programs requested specific timer resolutions over a period of time?
#### A: Yes, there are a few ways to monitor these requests here are two common methods, powercfg.exe energy report and a Windows Performance Recorder power usage resource analysis capture. See findings and analysis for the procedures.
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
</details>

### Keyboard DPC and Interrupt Latency (PS/2 VS USB)
#### Q: Does PS/2 keyboard driver provide lower DPC latency than USB keyboard driver?
#### A: No, not during the tests I performed but PS/2 keyboard driver latency was more stable.

<details><summary>Findings and Analysis</summary>

* Based on 20 tests results of each PS/2 and USB it was noted that USB keyboard driver generally has lower DPC latency (~4-8 microseconds), however PS/2 overall is ultra consistent at 8 microsecond times 97-99% of the time. The test performed was a 5 second timer to alt-tab ingame then starts a 30 second sleep timer after xperf data capture is started, in-game I only held a single key for the entire duration. Not necessarily a real world test but a test that is relatively consistent/repeatable.

* PS/2 interrupt latency is around 32 microseconds consistently, I'm using **Message Signaled Interrupts** for the USB controller so likely why it didn't show any results for the opposing side. Will see if I can look into that.

* See results:
[KeyboardDPCandInterruptLatency-PS2vsUSB.txt](https://github.com/djdallmann/GamingPCSetup/blob/master/RESEARCH/FINDINGS/KeyboardDPCandInterruptLatency-PS2vsUSB.txt)
</details>

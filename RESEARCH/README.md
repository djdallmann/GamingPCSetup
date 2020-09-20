# Research

This section contains different areas of research, performance impacts of various settings, tackling common misconceptions and just good to know information.
If you do use this or redistribute this in any way, please give due credit.

## Peripherals
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
* Disabling it may increase **throughput** should the throughput exceed the default receiving packets per second (pps) limit (NetworkThrottleIndex: 10 decimal, roughly ~ 15Mbps with 1500byte Ethernet MTU) but it does not improve DPC latency which is probably more beneficial for lower latency applications such as video games.

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

### Keyboard DPC and Interrupt Latency (PS/2 VS USB)
#### Q: Does PS/2 keyboard driver provide lower DPC latency than USB keyboard driver?
#### A: No, not during the tests I performed but PS/2 keyboard driver latency was more stable.

<details><summary>Findings and Analysis</summary>

* Based on 20 tests results of each PS/2 and USB it was noted that USB keyboard driver generally has lower DPC latency (~4-8 microseconds), however PS/2 overall is ultra consistent at 8 microsecond times 97-99% of the time. The test performed was a 5 second timer to alt-tab ingame then starts a 30 second sleep timer after xperf data capture is started, in-game I only held a single key for the entire duration. Not necessarily a real world test but a test that is relatively consistent/repeatable.

* PS/2 interrupt latency is around 32 microseconds consistently, I'm using **Message Signaled Interrupts** for the USB controller so likely why it didn't show any results for the opposing side. Will see if I can look into that.

* See results:
[KeyboardDPCandInterruptLatency-PS2vsUSB.txt](https://github.com/djdallmann/GamingPCSetup/blob/master/RESEARCH/FINDINGS/KeyboardDPCandInterruptLatency-PS2vsUSB.txt)
</details>

# Research

This section contains different areas of research, performance impacts of various settings, tackling common misconceptions and just good to know information.
If you do use this or redistribute this in any way, please give due credit.

## Network
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

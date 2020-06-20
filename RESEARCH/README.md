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

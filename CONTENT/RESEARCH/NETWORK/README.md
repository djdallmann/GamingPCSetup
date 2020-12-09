## Network
### Intel Interrupt Moderation
#### Q: Does interrupt moderation rate have an effect on deferred procedure call (DPC) or interrupt service routine (ISR) latency, and what are the key differences between each of the settings?
Yes, during the simulations it was found that it had more of an impact on DPC latency processing times over ISR, however each setting didn't scale equally as higher interrupt moderation values were used however this may be dependant other factors such as RSS, RSS affinity, rx/tx buffers, and timer resolution and the traffic simulation itself.

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
</details></br>

### NetworkThrottlingIndex
#### Q: Disabling NetworkThrottlingIndex feature improves overall network performance and latency
Not completely true, NDIS.sys DPC latency is increased quite notably when disabled.

<details><summary>Findings and Analysis</summary>

* A very common recommendation in many performance enhancement/gaming guides state that disabling *NetworkThrottleIndex* improves network performance and latency because in theory it should prevent rate limiting and quality of service (QoS) interactions. 
* The main purpose of NetworkThrottlingIndex is to reduce (rate limit) calls which would otherwise impact real time audio and perhaps cause stutter or other audible artifacts.
* Disabling it may increase **throughput** should the throughput exceed the default receiving packets per millisecond (ppms) limit (NetworkThrottleIndex: 10 decimal, 10 packets per millisecond, 10,000 received packets per second which is roughly ~ 15Mbps with 1500byte Ethernet MTU) but it does not improve DPC latency which is probably more beneficial for lower latency applications such as video games.
* It's unclear why DPC processing latency is much lower when this feature is enabled even when you're not reaching the inbound receive rate limit in comparison to disabling the feature completely which removes any throttling.
* To learn mouse about Network Throttling Index see the [Technical References](../../TECHNICAL%20REFERENCES/README.md) article **Multimedia Class Scheduler Service (MMCSS) Vista Multimedia Playback and Network Throughput** written by Mark Russinovich.

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
    
    ![NetworkThrottlingIndex Disabled](https://github.com/djdallmann/GamingPCSetup/blob/master/CONTENT/DOCS/IMAGES/NDIS.sys%20-%20Intel%20-%20DPC%20Latency%20Unoptimized.png)
    * **Enabled**, Decimal 10
    
    ![NetworkThrottlingIndex Enabled](https://github.com/djdallmann/GamingPCSetup/blob/master/CONTENT/DOCS/IMAGES/NDIS.sys%20-%20Intel%20-%20DPC%20Latency%20Optimized.png)
    
</details></br>

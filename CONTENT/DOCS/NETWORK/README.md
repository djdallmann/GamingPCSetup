# Network Configuration
## Operating System Specific Configuration
   * Ensure **Network Throttling Index feature is enabled**
     * **Recommendation:** Set a value between **10 and 20 decimal**, e.g. 15mbps-30mbps
     ```HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\NetworkThrottlingIndex``` 
     * See [research on Network Throttling Index](../../RESEARCH/README.md#networkthrottlingindex) and the impacts on NDIS DPC processing latency.
   * **Use a network adapter that supports Message-Signaled Interrupts (MSI/MSI-X)**
     * Most modern network adapters and associated driver configuration files define the use of MSI out of the box, when this is enabled it allows both the interrupt service routines and deferred procedure calls to be allocated to the same CPU cores allowing for better processing efficiency and improved performance.
     * To determine if Windows recognizes your adapter as RSS and MSI-X capable use the following commands, if identified as capable windows will allocate ISR/DPCs to CPU/Cores as specified by the RSS Base and Max core configuration discussed in the next step.
       ``` 
       As administrator run the following commands in powershell.exe
       
       > Get-NetAdapterHardwareInfo | fl
       Name                        : Ethernet 2
       InterfaceDescription        : Intel(R) Gigabit CT Desktop Adapter
       [...]
       LineBasedInterruptSupported : True
       MsiInterruptSupported       : True
       MsiXInterruptSupported      : True
       
       > Get-SmbClientNetworkInterface
       Interface Index RSS Capable RDMA Capable Speed  IpAddresses    Friendly Name
       --------------- ----------- ------------ -----  -----------    -------------
       14              True        False        1 Gbps {192.168.0.3} Ethernet 2
       ```
     * See the [Technical References](../../Technical%20References/README.md) page articles under **Microsoft Windows > Networking** regarding RSS, and RSS with Message Signaled Interrupts. You can also validate this optimization is working not only via performance increase but that the NDIS work is being locked to the predefined CPU cores with tools such as xperf.
   * Consider **binding your Receive Side Scaling (RSS) queue workloads to one or more CPUs**, assuming you have MSI/MSI-X enabled as noted above.
     * There has been notable NDIS DPC latency processing improvements observed (xperf isr/dpc latency analysis) through binding your RSS queues to specific cores. By default Windows primarily allocates much of the process and thread work to Core 0 of your CPU so there may be added benefit moving that workload to less used cores.
     * **Recommendation:** If you have a 4 core CPU, try binding RSS queues to cores 2 and 3 (3rd and 4th core)
     ``` 
         Run the following commands using powershell.exe as administrator
         Get-NetAdapterRSS
             Make note of the name associated with the network adapter e.g. Ethernet
         Set-NetAdapterRSS -Name "Ethernet" -BaseProcessorNumber 2
             Bind the RSS base core value to core 2 (3rd core), if you have 2 RSS queues
             enabled this should allocate work to 3rd and 4th core.
     ```
   * Disable NetBIOS over TCP in Network Adapter IPV4 settings to disable unnecessary SYSTEM listening service
     * **Network & Internet Settings > Change Adapter Options > Adapter Properties > Select TCP/IP v4 > Advanced > WINS tab > Disable NetBIOS over TCP/IP > Press OK**
     * Note: This change is immediate, and also listed in Post Install section but here for completeness.

## Intel Network Adapter Settings
*Offloading* features allows the network card to handle certain functions of the packet handling process reducing the overall cpu consumption, ideally allowing more cpu time for other tasks and your games.

- **Adaptive Inter-Frame Spacing**
   - Disabled
- **Flow Control**
   - Disabled
- **Interrupt Moderation and Moderation Rate**
   - My personal recommendation is to set this to *Medium* or leave it on *Adaptive* (default)
     * Try medium for a week or more then consider changing it if you believe something to be wrong from a network perspective.
     * A Medium interrupt moderataion value provided an acceptable DPC/ISR latency during both fully loaded 1Gbps TCP network simulation and also UDP communications during real world scenarios and during iperf tests which matched the traffic characteristics of the simulated games, Counter-Strike CS:GO and CS 1.6.
     * Many will recommend turning interrupt moderation off (including this one originally) however the increased interrupt rate can impact the users experience (perceived input response) during higher load where there is a combined use of realtime audio, gpu workloads, application and OS dependant cpu usage, usb device input and network throughput. If the intended performance measurement was not primarily reliant on user input response and stricly network/cpu based workload then having interrupt moderataion off would likely be ideal for lowest possible latency.
   - See [Research](../../RESEARCH/README.md#intel-interrupt-moderation)
- **IPv4 Checksum Offload**
   - RX & TX Enabled
- **Jumbo Packet**
   - Disabled
- **Large Send Offload V2 (IPv4)**
   - Disabled
- **Large Send Offload V2 (IPv6)**
   - Disabled
- **Receive Side Scaling**
   - Enabled
- **Maximum Number of RSS Queues**
   - N Queues, Use 2 or more queues when available.
- **Packet Priority & VLAN**
   - Both Enabled
- **Receive Buffers**
   - Increase if you have extra memory to spare, *recommended 1024 or higher.*
   - A lower value will results in dropped packets and decreased performance however a higher value could result in increased buffering during certain workloads, as per Microsoft's Performance Tuning Network Adapters guide.
     - Monitor your dropped packet rates during gameplay and adjust if necessary, a *slightly* higher value from the default should not result in increased buffering unless the traffic conditions reduce the rate at which data can be transmitted, often due to high load or congestion.
- **Transmit Buffers**
   - Increase if you have extra memory to spare, *recommended 1024 or higher.*
   - A lower value will results in dropped packets and decreased performance however a higher value could result in increased buffering during certain workloads, as per Microsoft's Performance Tuning Network Adapters guide
     - Monitor your dropped packet rates during gameplay and adjust if necessary, a *slightly* higher value from the default should not result in increased buffering unless the traffic conditions reduce the rate at which data can be transmitted, often due to high load or congestion.
- **TCP Checksum Offload (IPv4)**
   - Enabled
- **TCP Checksum Offload (IPv6)**
   - Enabled
- **UDP Checksum Offload (IPv4)**
   - Enabled
- **UDP Checksum Offload (IPv6)**
   - Enabled
- **Power Saving Options**
   - Disable all power saving options in drivers and for the adapter, more options are available in the latest Intel drivers sets.

For more information on these settings see the **Intel** and the **Microsoft Performance Tuning Network Adapters, Performance Tuning for Low Latency Packet Processing** support guides in the **Network** section of the [Technical References](../../Technical%20References/README.md) page.

## Realtek Network Adapter Settings
Realtek adapters and their drivers have shown to have worst DPC/ISR latency even after optimizations as noted in the Intel section above, however the Intel recommended settings above still apply to Realtek adapters. Will update this section and related settings if further research and evidence is accumulated to show otherwise.

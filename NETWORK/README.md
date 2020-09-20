# Network Configuration
## Operating System Specific Configuration
Pending

## Intel Based Network Adapter Settings
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
   - See [Research](../RESEARCH/README.md#intel-interrupt-moderation)
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

For more information on these settings see the **Intel** and the **Microsoft Performance Tuning Network Adapters, Performance Tuning for Low Latency Packet Processing** support guides in the **Network** section of the [Technical References](../Technical%20References/README.md) page.

## Realtek
Realtek adapters and their drivers have shown to have worst DPC/ISR latency even after optimizations as noted in the Intel section above, however the Intel recommended settings above still apply to Realtek adapters. Will update this section and related settings if further research and evidence is accumulated to show otherwise.

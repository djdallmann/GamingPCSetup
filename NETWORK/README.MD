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
   - Either set this to *Off* or leave it on *Adaptive* for latency sensitive applications
- **IPv4 Checksum Offload**
   - RX & TX Enabled
- **Jumbo Packet**
   - Disabled
- **Large Send Offload V2 (IPv4)**
   - Enabled
- **Large Send Offload V2 (IPv6)**
   - Enabled
- **Receive Side Scaling**
   - Enabled
- **Maximum Number of RSS Queues**
   - N Queues, Use 2 or more queues when available.
- **Packet Priority & VLAN**
   - Both Enabled
- **Receive Buffers**
   - Increase if you have extra memory to spare, *recommended 1024 or higher.*
   - A lower value will results in dropped packets and decreased performance, as per Microsofts
- **Transmit Buffers**
   - Increase if you have extra memory to spare, *recommended 1024 or higher.*
   - A lower value generally results in dropped packets and decreased performance.
- **TCP Checksum Offload (IPv4)**
   - Enabled
- **TCP Checksum Offload (IPv6)**
   - Enabled
- **UDP Checksum Offload (IPv4)**
   - Enabled
- **UDP Checksum Offload (IPv6)**
   - Enabled

For more information on these settings see the **Intel** and the **Microsoft Performance Tuning Network Adapters, Performance Tuning for Low Latency Packet Processing** support guides in the **Network** section of the [Technical References](../Technical%20References/README.md) page.

## Realtek
Pending

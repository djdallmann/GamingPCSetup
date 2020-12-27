## Electrical
### Ground Loops, EMI, EMF, EMC
 * Understanding, Finding & Eliminating Ground Loops, CEDIA Class EST016. Instructor. Bill Whitlock. President & Chief
   * https://web.mit.edu/~jhawk/tmp/p/EST016_Ground_Loops_handout.pdf
 * Addressing Electromagnetic Interference With Phidgets, Phidgets Inc. 2017.
   * https://www.phidgets.com/docs/Addressing_Electromagnetic_Interference_with_Phidgets
 * Noise Suppressing Basic Course, Murata Americas
   * https://www.murata.com/en-us/products/emc/emifil/knowhow/basic
 * Practical Shielding, EMC/EMI, Noise Reduction, Earthing and Circuit Board Layout, Engineering Institute of Technology
   * https://www.eit.edu.au/resources/practical-shielding-emc-emi-noise-reduction-earthing-and-circuit-board-layout/
 * Susceptibility of PC to electromagnetic interference, IEEE, Defence Science and Technology Organisation, Piotrowski, 2009
   * https://ieeexplore.ieee.org/document/5349776
 * EMI Design Guidelines for USB Components, Intel 
    * http://www.ti.com/sc/docs/apps/msp/intrface/usb/emitest.pdf
 * USB Voltage Drop and Droop Measurement, Intel
    * http://intel-vintage-developer.eu5.org/DESIGN/USB/PAPERS/VDROOP.PDF
 * Trends in EM susceptibility of IT equipment, IEEE, IEEE Transactions on Electromagnetic Compatibility, R. Hoad, N.J. Carter, D. Herke, S.P. Watkins, 2004
   * https://ieeexplore.ieee.org/document/1325793
 * Keys to Control Noise, Interference and EMI in PC Boards - Hartley, Altium
   * https://www.youtube.com/watch?v=ZYUYOXmo9UU
    
## BIOS
### Optimizations
  * FUJITSU Server PRIMERGY - BIOS optimizations for Xeon Scalable processors based systems. BIOS settings for performance, low-latency and energy efficiency
    *  https://sp.ts.fujitsu.com/dmsp/Publications/public/wp-skylake-RXTX-bios-settings-primergy-ww-en.pdf
  * Keyboard Prompts During Boot Process (POST) for Intel® Desktop Boards, Intel 2018
    * https://www.intel.ca/content/www/ca/en/support/articles/000005672/boards-and-kits/desktop-boards.html
    * Note the shortcut for Intel® Management Engine BIOS Extension (Intel® MEBX)
    
### Advanced Programmable Interrupt Controller (APIC)
  * 82093AA I/O ADVANCED PROGRAMMABLE INTERRUPT CONTROLLER (IO APIC), Intel
    * https://pdos.csail.mit.edu/6.828/2016/readings/ia32/ioapic.pdf
  
### C-States, P-States, PC-States
   * C-states, C-states and even more C-states (Part 1)
     * https://software.intel.com/en-us/blogs/2008/03/27/update-c-states-c-states-and-even-more-c-states/
   * There's got to be a catch (Part 2)
     * https://software.intel.com/en-us/blogs/2008/04/29/theres-got-to-be-a-catch
   * Energy-Efficient Platforms – Considerations for Application Software and Services, Intel Whitepaper, Intel 2011
     * https://www.intel.com/content/dam/doc/white-paper/energy-efficient-platforms-2011-white-paper.pdf
   * The Importance of UEFI Settings and Hardware C-States, Lenovo, LenovoPress 2017
     * https://lenovopress.com/lp0632-uefi-settings-and-hardware-c-states
   * Understanding P-State Control on Intel Xeon Scalable Processors to Maximize Energy Efficiency, Lenovo, LenovoPress 2019
     * https://lenovopress.com/lp0870-understanding-pstate-control-to-maximize-energy-efficiency

## Microsoft Windows
### Interrupt Service Routines (ISR), Deferred Procedure Calls (DPC), Message-Signaled Interrupts (MSI)
   * Microsoft Hardware - Kernel-Mode Driver Architecture - Introduction to Interrupt Service Routines, Microsoft Docs
      * https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/introduction-to-interrupt-service-routines
   * Microsoft Hardware - Kernel-Mode Driver Architecture - Introduction to Deferred Procedure Calls, Microsoft Docs
      * https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/introduction-to-dpcs
   * Microsoft Hardware - Kernel-Mode Driver Architecture - Introduction to Deferred Procedure Calls, Microsoft Docs
      * https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/introduction-to-message-signaled-interrupts
   * Reducing Interrupt Latency Through the Use of Message Signaled Interrupts, Intel 2009, James Coleman
Performance Architect Intel Corporation
      * https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/msg-signaled-interrupts-paper.pdf
   * Microsoft Hardware - Kernel-Mode Driver Architecture - Enabling Message-Signaled Interrupts in the Registry, Microsoft Docs
      * https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/enabling-message-signaled-interrupts-in-the-registry
      
### Networking
   * Network Subsystem Performance Tuning, Microsoft Windows IT Pro Center 2019
      * https://docs.microsoft.com/en-us/windows-server/networking/technologies/network-subsystem/net-sub-performance-top
   * Advanced Settings for Intel® Ethernet Adapters, Intel 2018
      * https://www.intel.com/content/www/us/en/support/articles/000005593/network-and-i-o/ethernet-products.html
   * Tuning Throughput Performance for Intel® Ethernet Adapters, Intel 2019
      * https://www.intel.ca/content/www/ca/en/support/articles/000005811/network-and-i-o/ethernet-products.html
   * Network terminology and technology, tuning and performance, Konstantin Lepikhov, 2018, Geant eduPERT Knowledge Base
      * https://wiki.geant.org/display/public/EK/Network
   * Metered Internet connections: FAQ, Microsoft Support, Microsoft
      * https://support.microsoft.com/en-ca/help/17452/windows-metered-internet-connections-faq
   * Windows Transport converges on two Congestion Providers: Cubic and LEDBAT
      * https://techcommunity.microsoft.com/t5/Networking-Blog/Windows-Transport-converges-on-two-Congestion-Providers-Cubic/ba-p/339819
   * Guidance for configuring IPv6 in Windows for advanced users, Microsoft Windows Support, Microsoft 2019
      * https://support.microsoft.com/en-us/help/929852/guidance-for-configuring-ipv6-in-windows-for-advanced-users
   * Information about the TCP Chimney Offload, Receive Side Scaling, Microsoft Support, Microsoft 2014
      * https://support.microsoft.com/en-us/help/951037/information-about-the-tcp-chimney-offload-receive-side-scaling-and-net
   * Introduction to Receive Side Scaling, Microsoft Hardware Dev Center, Microsoft 2017
      * https://docs.microsoft.com/en-us/windows-hardware/drivers/network/introduction-to-receive-side-scaling
   * Non-RSS Receive Processing, Microsoft Hardware Dev Center, Microsoft 2017
      * https://docs.microsoft.com/en-us/windows-hardware/drivers/network/non-rss-receive-processing
   * RSS with Message Signaled Interrupts, Microsoft Hardware Dev Center, Microsoft 2017
      * https://docs.microsoft.com/en-us/windows-hardware/drivers/network/rss-with-message-signaled-interrupts
   * Placebo setting: QoS bandwidth reservation, Microsoft DevBlogs, Raymon Chen, Kernel Developer, Microsoft 2006
      * https://devblogs.microsoft.com/oldnewthing/20061123-14/?p=28923

### Filesystem and Disk
   * Configuring the Disk and File System for Performance, Microsoft Docs 2008
      * https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-2000-server/cc938627(v=technet.10)

### Drivers
   * What Determines When a Driver Is Loaded, Microsoft Docs 2017
      * https://docs.microsoft.com/en-us/windows-hardware/drivers/ifs/what-determines-when-a-driver-is-loaded
   * Tools for Verifying Drivers: Driver Verifier, Microsoft Hardware Dev Center, Microsoft 2017 
      * https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/driver-verifier

### Services
   * Guidance on disabling system services on Windows Server 2016 with Desktop Experience, Microsoft, Microsoft Docs
      * https://docs.microsoft.com/en-us/windows-server/security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server
   * Per-user services in Windows 10 and Windows Server
      * https://docs.microsoft.com/en-us/windows/application-management/per-user-services-in-windows
   * Multimedia Class Scheduler Service (MMCSS) Vista Multimedia Playback and Network Throughput, Mark Russinovich's Technical Blog 2007
      * https://web.archive.org/web/20071012033145/http://blogs.technet.com/markrussinovich/archive/2007/08/27/1833290.aspx
   * Multimedia Class Scheduler Service, Windows Dev Center, Microsoft 2018
      * https://docs.microsoft.com/en-us/windows/win32/procthread/multimedia-class-scheduler-service
   * Multimedia Class Scheduler Service (MMCSS), How to use the throttling mechanism to control network performance in Windows Vista, Microsoft Help and Support, Microsoft 2008
      * https://web.archive.org/web/20080724025429/http://support.microsoft.com/kb/948066

### Latency
   * Intel Optimizing Computer Applications for Latency: Part 1: Configuring the Hardware, Intel 2017, Evgueny Khartchenko
      * https://software.intel.com/en-us/articles/optimizing-computer-applications-for-latency-part-1-configuring-the-hardware
   * Intel Optimizing Computer Applications for Latency: Part 2: Tuning Applications, Intel 2017, Evgueny Khartchenko
      * https://software.intel.com/en-us/articles/optimizing-computer-applications-for-latency-part-2-tuning-applications
### Timers, Clocks and Time Keeping
   * Microsecond Resolution Time Services for Windows, The Windows Time Stamp Project, Arno Lentfer, June 2012
      * http://www.windowstimestamp.com/description
   * Game Timing and Multicore Processors, Microsoft Dev Center, May 2018
      * https://docs.microsoft.com/en-us/windows/win32/dxtecharts/game-timing-and-multicore-processors?redirectedfrom=MSDN
   * timeGetTime versus GetTickCount, Random ASCII – tech blog of Bruce Dawson, Bruce Dawson, Former Employee of Valve, Microsoft XBox 360 and Google Chrome Performance Management Teams
      * https://randomascii.wordpress.com/2013/05/09/timegettime-versus-gettickcount/

### USB
   * Demystifying USB Selective Suspend, Microsoft USB Blog 2011, Vivek Gupta
      * https://techcommunity.microsoft.com/t5/Microsoft-USB-Blog/Demystifying-USB-Selective-Suspend/ba-p/270736
   * Common issues in USB 3.0 Devices, Microsoft USB Blog 2012, Vivek Gupta
      * https://techcommunity.microsoft.com/t5/Microsoft-USB-Blog/Common-issues-in-USB-3-0-devices/ba-p/270760
   * Answering the question "What's wrong with my device?" using USB trace messages, Microsoft USB Blog 2009, Philip Ries
      * https://techcommunity.microsoft.com/t5/Microsoft-USB-Blog/Answering-the-question-quot-What-s-wrong-with-my-device-quot/ba-p/270697
   * Capturing USB ETW traces with Microsoft Message Analyzer (MMA), Microsoft USB Blog, Andrea Keating & Eliyas Yakub
      * https://techcommunity.microsoft.com/t5/Microsoft-USB-Blog/Capturing-USB-ETW-traces-with-Microsoft-Message-Analyzer-MMA/ba-p/270811
      * https://docs.microsoft.com/en-us/windows-hardware/drivers/usbcon/capture-and-view-ing-usb-traces-with-microsoft-message-analyzer-
      
### Thermal Throttling
   * Defective Heat Sinks Causing Garbage Gaming, Random ASCII – tech blog of Bruce Dawson, Bruce Dawson, Former Employee of Valve, Microsoft XBox 360 and Google Chrome Performance Management Teams
      * https://randomascii.wordpress.com/2013/08/06/defective-heat-sinks-causing-garbage-gaming/
            
### NVIDIA
   * How Often to Update Graphics Card Display Drivers, NVIDIA Knowledgebase, NVIDIA 2017
     * https://nvidia.custhelp.com/app/answers/detail/a_id/34/
   * Setting "Power management mode" from Adaptive to Maximum Performance, NVIDIA Knowledgebase, NVIDIA 2014
     * https://nvidia.custhelp.com/app/answers/detail/a_id/3130/
   * How to calibrate your monitor, NVIDIA GeForce Guides, NVIDIA 2015
     * https://www.geforce.com/whats-new/guides/how-to-calibrate-your-monitor
   * Graphics card basic troubleshooting for video corruption / crashing / system lock ups / freezes / BSOD, NVIDIA Knowledgebase, NVIDIA 2014
     * https://nvidia.custhelp.com/app/answers/detail/a_id/3565/
   * Collecting GPU logs using GPU-Z, NVIDIA Knowledgebase, NVIDIA 2018
     * https://nvidia.custhelp.com/app/answers/detail/a_id/4749/
   * How to Get Rid of Lag, NVIDIA GeForce Guides
     * https://www.geforce.com/whats-new/guides/how-to-get-rid-of-lag-guide
   * How to generating an event trace log for GPUView to troubleshoot performance issues/low FPS/game stutter, NVIDIA Knowledgebase, NVIDIA 2019
     * https://nvidia.custhelp.com/app/answers/detail/a_id/3507/
   * How to generate a DirectX Diagnostic Tool report (dxdiag), NVIDIA Knowledgebase, NVIDIA 2015
     * https://nvidia.custhelp.com/app/answers/detail/a_id/3721/
   * Are You Running Out of Video Memory? Detecting Video-Memory Overcommitment using GPUView, NVIDIA Gameworks Blog, NVIDIA 2015 
     * https://developer.nvidia.com/content/are-you-running-out-video-memory-detecting-video-memory-overcommitment-using-gpuview

### Misc
   * Windows Hardware Dev Center Archive, Microsoft
      * https://docs.microsoft.com/en-us/previous-versions/windows/hardware/download/dn550976(v=vs.85)
   * Adjust visual effects for best performance should really be called Adjust visual effects for crappiest appearance, Raymon Chen, Kernel Developer, Microsoft 2013
      * https://devblogs.microsoft.com/oldnewthing/20130327-00/?p=4833
   *  Announcing Windows 10 Insider Preview Build 17101 for Fast & Build 17604 for Skip Ahead, Microsoft Windows Insider Blog, Microsoft 2018
      * https://blogs.windows.com/windows-insider/2018/02/14/announcing-windows-10-insider-preview-build-17101-fast-build-17604-skip-ahead/
      * Primary reference to Ultimate power scheme, documentation seems limited. Present/unhidden on LTSC by default.
   * Virus scanning recommendations for Enterprise computers that are running currently supported versions of Windows, Microsoft - Support - Windows Support, Microsoft 2020
      * https://support.microsoft.com/en-us/help/822158/virus-scanning-recommendations-for-enterprise-computers

## Troubleshooting
### Windows Performance
  * Windows Performance Analyzer step-by-step guide, Microsoft Hardware Dev Center, Microsoft 2017 
    * https://docs.microsoft.com/en-us/windows-hardware/test/wpt/wpa-step-by-step-guide
  * Common In-Depth Analysis Issues, Microsoft Hardware Dev Center, Microsoft 2017
    * https://docs.microsoft.com/en-us/windows-hardware/test/assessments/common-in-depth-analysis-issues
  * Using GPUView for determining the performance of the graphics processing unit (GPU) and CPU, Microsoft Hardware Dev Center, Microsoft 2017
    * https://docs.microsoft.com/en-us/windows-hardware/drivers/display/using-gpuview
    * https://graphics.stanford.edu/~mdfisher/GPUView.html
  * Performance Tuning Guidelines for Windows Server 2016, Microsoft Docs, Microsoft 2017
    * https://docs.microsoft.com/en-us/windows-server/administration/performance-tuning/
  * Mark's Blog : The Case of the System Process CPU Spikes, Mark Russinovich's Technical Blog 2008
    * https://web.archive.org/web/20081217023055/http://blogs.technet.com/markrussinovich/archive/2008/04/07/3031251.aspx
  * Book: Windows Performance Analysis Field Guide, Clint Huffman
    * https://www.amazon.com/Windows-Performance-Analysis-Field-Guide-ebook/dp/B00MVTQWLY/
  * Book: Windows Internals, Part 1: System architecture, processes, threads, memory management, and more (Developer Reference) 7th Edition, Authors:
Pavel Yosifovich, Mark Russinovich, David Solomon, Alex Ionescu
    * https://www.amazon.com/Windows-Internals-Part-architecture-management/dp/0735684189/
  * Delivering a great media experience, Microsoft Windows Hardware Developer, Microsoft 2017
    * https://docs.microsoft.com/en-us/windows-hardware/test/weg/delivering-a-great-media-experience

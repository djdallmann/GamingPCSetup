# Troubleshooting

This section contains information that may help identify and resolve different computer systems, component and electrical issues

* [Electrical Interference](ELECTRICALINTERFERENCE.MD)
* [Media Playback](MEDIAPLAYBACK/README.md)
* [Video Card](VIDEOCARD.md)

## Tools
### Software
  * Windows Driver Kit (WDK), Microsoft
    * https://docs.microsoft.com/en-us/windows-hardware/drivers/download-the-wdk
  * Windows Performance Toolkit (WPT), Microsoft
    * A set of tools used to record and analyze Windows low level event traces (ETL), more notably Windows Performance Recorder (WPR), Windows Performance Analyzer (WPA) and Media eXperience Analyzer (MXA or XA)
    * https://docs.microsoft.com/en-us/windows-hardware/test/wpt/
    * https://docs.microsoft.com/en-us/windows-hardware/test/weg/delivering-a-great-media-experience
  * WinDbg (Win Debug)
    * https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/debugger-download-tools
  * Windows Sysinternals, Microsoft
    * Sysinternals utilities help you manage, troubleshoot and diagnose your Windows systems and applications.
    * https://docs.microsoft.com/en-us/sysinternals/
  * Microsoft diskspd
    * DiskSpd is a storage performance tool from the Windows, Windows Server and Cloud Server Infrastructure engineering teams at Microsoft. The tool CrystalDiskMark uses DiskSpd under the hood.
    * https://github.com/microsoft/diskspd
    * https://github.com/Microsoft/diskspd/wiki
  * Microsoft ctsTraffic
    * ctsTraffic is a highly scalable client/server networking tool giving detailed performance and reliability analytics.
    * https://github.com/microsoft/ctsTraffic
  * Microsoft Performance HUD
    * A real-time performance profiler that detects and identifies the source of high resource usage, GDI leaks, memory leaks and more.
    * https://www.microsoft.com/en-us/download/100813
  * Windows Performance Monitor
    * A tool that comes installed on most Windows platforms by default, typically used as a first level system triage and monitoring tool.
  * PAL (Performance Analysis of Logs)
    * A tool for windows performance analysis that uses perfmon log data and thresholds to help identify common issues and fluctuations. Supports use of custom templates which could help measure the impact of a change across multiple areas of a system.
    * https://github.com/clinthuffman/PAL
  * Wireshark
    * Wireshark® is a network protocol analyzer. It lets you capture and interactively browse the traffic running on a computer network.
    * https://www.wireshark.org/
  * GPUView
    * https://docs.microsoft.com/en-us/windows-hardware/drivers/display/using-gpuview
    * https://graphics.stanford.edu/~mdfisher/GPUView.html
  * Intel® Extreme Tuning Utility - Intel® XTU
    * https://downloadcenter.intel.com/download/24075/Intel-Extreme-Tuning-Utility-Intel-XTU
  * Intel® Performance Counter Monitor (Intel® PCM)
     * Intel® Performance Counter Monitor - A Better Way to Measure CPU Utilization: Provides metrics for CPU cache hits and misses, PCIe metrics such as bandwidth per device (for select processor families)
     * https://www.intel.com/content/www/us/en/developer/articles/tool/performance-counter-monitor.html
     * https://github.com/intel/pcm
  * HWiNFO Diagnostic Software
    * https://www.hwinfo.com/download/
  * FIO - Flexible I/O tester
    * https://fio.readthedocs.io/en/latest/fio_doc.html
  * nvidia-smi - NVIDIA System Management Interface
    * A multipurpose Nvidia graphics management and monitoring tool. 
    * Comes with driver installations, path may vary for each driver installation.
      * e.g. C:\Windows\System32\DriverStore\FileRepository\nv_dispi.inf_amd64_xxxxxxxxxxxxxxx\nvidia-smi.exe
  * NVIDIA Cleanup Tool (For Drivers, Applications and Utilities)
    * https://developer.nvidia.com/cleanup-tool
  * AMD Cleanup Utility (Graphics and Audio Drivers/Software)
    * https://www.amd.com/en/support/kb/faq/gpu-601
  * MSI Afterburner
    * Graphics card monitoring, overclocking and performance management tool.
    * https://www.msi.com/Landing/afterburner/graphics-cards
  * TechPowerUp Counter Control
    * _Microsoft's Windows Defender anti-virus software will sporadically take over all hardware performance counters and use them in a way that reduces system performance significantly. Using Counter Control you can identify this and mitigate it._
    * https://www.techpowerup.com/download/counter-control/
    * https://www.techpowerup.com/295877/windows-defender-can-significantly-impact-intel-cpu-performance-we-have-the-fix
    * https://www.overclock.net/threads/9900k-5ghz-effective-clock-not-boosting-to-max.1798506/page-2#post-28990420
   
### Hardware
  * Affordable Advanced GQ EMF-390 Multi-Field, Multi-Function EMF Meter and RF Spectrum Power Analyzer
    * This device can also take screenshots, and record data over longer periods of time and allow you to save and analyze it on your PC at a later date.
    * Device also has an internal clock which can be syncd to your computers time, this will allow for more precise analysis for point in time references.
    * https://www.gqelectronicsllc.com/comersus/store/comersus_viewItem.asp?idProduct=5678&idAffiliate=1169

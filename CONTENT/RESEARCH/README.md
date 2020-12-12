# Research

This section contains different areas of research, performance impacts of various settings, tackling common misconceptions and just good to know information.
If you do use this or redistribute this in any way, please give due credit.

[Network Performance](NETWORK/README.md)
- Does interrupt moderation rate have an effect on deferred procedure call (DPC) or interrupt service routine (ISR) latency, and what are the key differences between each of the settings?
- Does disabling NetworkThrottlingIndex feature improve overall network performance and latency?

[Peripherals](PERIPHERALS/README.md)
- Should you clean your mouse sensor lens regularly, at what frequency and what cleaning methods are recommended?
- Does the mouse LOD affect tracking on different surfaces, and do wear patterns also influence tracking with the same LOD?
- How are the HyperX Fury S Speed and Control fabrics different in texture? Do they have noticeably different resistance as a tracking surface?
- Can you define the interrupt moderation rate for USB controllers? Do different versions of windows have different default values?

[Windows Drivers](WINDRIVERS/README.md)
- What are the default non-paged pool allocations for mouclass.sys and kbdclass.sys dataqueuesize parameters indicated by the mouclass and kbdclass event providers?
- How do the values in keyboarddataqueuesize and mousedataqueuesize affect the non-page pool memory allocation? How can you tell?

[Windows Kernel](WINKERNEL/README.md)
- If you modify Win32PrioritySeparation (process foreground and background quantum lengths) in the registry does it update in realtime or does it require a system restart?
- Can you micro-increment/adjust the windows timer resolution?
- Can you monitor which programs requested specific timer resolutions over a period of time?
- Does PS/2 keyboard driver provide lower DPC latency than the USB keyboard driver?
- What information does the Windows HAL Event Provider capture when you change different bcdedit settings such as useplatformclock and useplatformtick in combination with the High Precision Event Timer (HPET) setting in the BIOS? What are the default values on/off vs undefined? Does the bcdedit tscsyncpolicy change the outcome in the event audit?

[Windows Registry](WINREGISTRY/README.md)
- Is there an easy way to see what registry keys are accessed or modified by every process or dll upon execution or during runtime?
- What are some of the registry keys accessed on boot? Do they reveal potentially hidden registry keys and values?

[Windows Services](WINSERVICES/README.md)
* **Multimedia Class Scheduler Service (MMCSS)**
  - What is Multimedia Class Scheduler Service (MMCSS)?
  - Is it possible to tell what processes register to MMCSS and can you determine which tasks they requested?
  - What types of MMCSS tasks are requested by common applications?
  - Does CSRSS.exe (Client/Server Run-Time Subsystem) or DWM.exe (Desktop Window Manager) ever use MMCSS?
  - Can you take advantage of the MMCSS boosted CSRSS and DWM thread priorities (DwmEnableMMCSS) while using a fullscreen exclusive application?
  - Do any processes or threads register with MMCSS during the boot process?
  - Do any processes or threads register with MMCSS task DisplayPostProcessing?
  - Do any processes or threads register with MMCSS task Games?
  - What the heck is NoLazyMode, is it real? What does it do?
  - What does the hidden MMCSS Latency Sensitive registry key actually do? What is the default value?
  - Does the MMCSS task Clock Rate registry setting do anything? 
  - What is the BackgroundPriority mmcss registry setting? Does it have anything to do with the Background Only registry key?
  - Does the hidden MMCSS SystemProfile registry setting LazyModeTimeout alter the running state?
  - Does the hidden MMCSS SystemProfile registry settings MaxThreadsTotal and MaxThreadsPerProcess restrict overall use of MMCSS?
  - Does the MMCSS task registry setting SFIO Priority actually change the IO Priority or does it do nothing like Microsoft's documentation states?
  - How does MMCSS map the defined priorities and scheduling category in relation to the values recorded by the event provider?
  - Does the MMCSS AlwaysOn registry setting exist?
  - What's actually happening inside MMCSS on a millisecond time scale? What variables are there and how do they come into play?

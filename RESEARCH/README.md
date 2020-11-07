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

[Windows Kernel](WINKERNEL/README.md)
- If you modify Win32PrioritySeparation (process foreground and background quantum lengths) in the registry does it update in realtime or does it require a system restart?
- Can you micro-increment/adjust the windows timer resolution?
- Can you monitor which programs requested specific timer resolutions over a period of time?
- Does PS/2 keyboard driver provide lower DPC latency than the USB keyboard driver?

[Windows Registry](WINREGISTRY/README.md)
- Is there an easy way to see what registry keys are accessed or modified by every process or dll upon execution or during runtime?

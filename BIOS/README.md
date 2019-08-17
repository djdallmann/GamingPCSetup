## BIOS Configuration
1. Reset BIOS to optimal Defaults
   - Most BIOS provide an option for this in one of the menus
2. Disable C-State
   - CPU Enhanced Halt (C1E), C3, C6, C7, C8
3. Set Package C-State Limit if available to a low cstate values such as C2 or C0/C1 (lowest).
   - The deeper the C-State (C6, C7, C8) the more latency is introduced due to the time it takes to restore the active power state.
4. Disable Intel (R) Speed Shift Technology
5. Disable CPU Enhanced Intel Speedstep Technology (EIST) Function
6. Enable Turbo Boost
7. Enable XMP
8. Set any Fast Boot Settings to OFF
   - This may be in the Memory and other sections which let you control what devices that are powered up before it reaches the OS to save boot times.
9. Disable any Active State Power Management (ASPM)/Aggressive Link Power Management (ALPM) settings
   - This may be in the SATA and/or PCI configuration sections, check each section
10. Set your SATA disk controlled mode to AHCI
11. Disable OnBoard Video, Audio or Lan Controller if you have a PCI/USB one that is or will be installed.
12. Set your Primary Display Output to your dedicated graphics card if present
13. Leave High Precision Event Timer (HPET) ON in the BIOS if present or if it is enabled by default
14. Make sure Platform Power Management is disabled
15. Disable Legacy USB Support, Port 60/64 Emulation
    - Having them enabled may cause the CPU to enter System Management Mode (SMM) via System Management Interrupt (SMI) which is a non blocking interrupt and may introduce minor latency.
16. Disable any onboard LED traces/lights, e.g. Gigabyte Ambient LED
17. Set your PCI Express Max Link Speed to Gen3, devices can negotiate lower spec as needed.

## BIOS Configuration
1. Reset BIOS to optimal Defaults
   - Most BIOS provide an option for this in one of the menus
2. Disable C-States 
   - There may be a single option to disable them all, or you may need to disable each individually.
   - CPU Enhanced Halt (C1E), C3, C6/7, C8
3. Set Package C-State Limit if available to C0/C1 (Gigabyte Motherboards)
4. Disable Intel (R) Speed Shift Technology
5. Disable CPU Enhanced Intel Speedstep Technology (EIST) Function
6. Disable Turbo Boost and Memory XMP Profile, use base speeds
7. Set any Fast Boot Settings to OFF
   - This may be in the Memory section and possibly BIOS section
   - Memory Boot Mode: Fast Boot Disabled
8. Disable any Active State Power Management (ASPM)/Aggressive Link Power Management (ALPM) settings
   - This may be in the SATA and/or PCI configuration sections, check them all
9. Set your SATA disk controlled mode to AHCI
10. Disable OnBoard Video, Audio or Lan Controller if you have a PCI/USB one that is or will be installed.
11. Set your Primary Display Output to your dedicated graphics card if present
12. Leave High Precision Event Timer (HPET) ON in the BIOS if present or if it is enabled by default
13. Enable ErP or EuP Ready
    - Will affect power when the system is shutdown, usb devices and lights will not be powered on when shutdown.
14. Make sure Platform Power Management is disabled
15. Set CPU Vcore Loadline Calibration to Standard if set to Auto (Gigabyte)

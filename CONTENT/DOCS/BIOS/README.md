## BIOS Configuration
1. **Reset BIOS to optimal defaults**
   - Most BIOS provide an option for this in one of the available menus
2. **Set the Package C-State Limit**
   - When higher C-States values are made available such as  C6, C7, C8 the more latency is introduced due to the time it takes to restore and transition the active power state.
   - Some configurations may be negatively impacted by disabling all avaiable C-States, if this is the case then try limiting the value to **C2 or C3**. This is likely due to a bottleneck in memory or cpu.
3. **Disable Intel (R) Speed Shift Technology**
4. **Disable CPU Enhanced Intel Speedstep Technology (EIST) Function**
5. **Turbo Boost**
   - If isolating performance behavior issues, disable.
   - If you'd like to use Turbo Boost frequencies I'd recommend using a static overclock to reduce minor overhead from dynamic frequency scaling, otherwise **enable**.
6. **Enable Memory XMP Profile**
7. Set any **Fast Boot Settings to OFF**
   - This may be in the Memory and other sections which let you control what devices that are powered up before it reaches the OS to save boot times.
8. **Disable any Active State Power Management (ASPM)/Aggressive Link Power Management (ALPM) settings**
   - This may be in the SATA and/or PCI configuration sections, check each section
9. Set your **SATA disk controlled mode to AHCI**
10. Disable OnBoard Video, Audio or Lan Controller if you have a PCI/USB one that is or will be installed.
11. Set your **Primary Display Output to your dedicated graphics** card if present
12. Leave High Precision Event Timer (HPET) ON in the BIOS if present or if it is enabled by default
13. Make sure **Platform Power Management is disabled**
14. **Disable any onboard LED/RGB traces/lights**, e.g. Gigabyte Ambient LED
15. Set your **PCI Express Max Link Speed to Gen3**, devices can negotiate lower spec as needed.
16. Set a static voltage for CPU vcore then use load line calibration (LLC) to help maintain constant voltage under load.
    - Reference CPU manufacturers documention as a guideline for vcore specifications.
    - Using auto/automatic values will increase voltage variability since it dynamically scales.
    - Use HWInfo and HWInfoCompare to compare static vs auto voltages, monitor for performance and stability.
    - Test out different LLC levels while under load (e.g. your game)
    - You should be able to achieve a near constant vcore voltage or at least a constant value 90% or more of the time without excessive overvolting or extreme LLC.

### Other Considerations
* Disable or Enable Legacy USB Support & Port 60/64 Emulation
    - Having them enabled **may** cause the CPU to enter System Management Mode (SMM) via System Management Interrupt (SMI) which is a non blocking interrupt and may introduce minor latency.
    - If you're setting up a non UEFI operating system this may need to be on during install and can be turned off afterwards.
    - Your mileage may vary on this configuration option, typically the default is Legacy USB Support enabled. Try it and see if it negatively impacts your perceived user experience.

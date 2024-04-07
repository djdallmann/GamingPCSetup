## Building Intel® Performance Counter Monitor (Intel® PCM) on Windows
This process is based on the official github page when using third-party open source WinRing0 driver 
https://github.com/intel/pcm/blob/master/doc/WINDOWS_HOWTO.md

### Install Visual Studio
Install Visual Studio Community Edition with the following workloads, options and individual components:
  * URL: https://visualstudio.microsoft.com/downloads/
  * Workloads
    * Desktop development with C++
      * C++ CMake tools for Windows
    * .NET desktop development
  * Individual components
    * Search "Libs for Spectre" and select "MSVC v143 - VS  2022 C++ x64/x86 Spectre-mitigated libs(Latest)"

### Download the following repositories and dependencies
* https://github.com/intel/pcm/archive/refs/tags/202403.zip
* https://github.com/simdjson/simdjson/archive/e6c90b8efb5a4f3fbd93db01181c2b22e0c92167.zip
* https://raw.githubusercontent.com/pciutils/pciids/master/pci.ids
* https://github.com/Velocidex/WinPmem/blob/master/kernel/binaries/winpmem_x64.sys

### Prepare the code
* Extract the pcm release 202403 to a folder
* Extract simdjson source code to the pcm "src/simdjson" subfolder

### Compile and build
* Open "Native Tools Command Prompt" that came with Visual Studio
* Change directory to pcm source code you extracted, e.g. ```cd C:\Users\<youruser>\Downloads\pcm-202403\```
* Run these commands:
  * ```cmake -B build```
  * ```cmake --build build --config Release --parallel```

### Copy the build and dependencies to Program Files folder
* Create folder ```C:\Program Files (x86)\PCM```
* Copy the build files to the folder above, ```C:\Users\<youruser>\Downloads\pcm-202403\build\bin\Release\*```
* Copy the following files to the folder:
  * pci.ids
  * winpmem_x64.sys

### Obtain third-party open source WinRing0 driver from TechPowerUp Real Temp software package.
* Download http://www.techpowerup.com/realtemp/, tested with RealTemp_370.zip
* Open the zip file and copy the following files to ```C:\Windows\System32\``` and ```C:\Program Files (x86)\PCM\```
   * WinRing0.dll
   * WinRing0.sys
   * WinRing0x64.dll
   * WinRing0x64.sys

## Test the commands and determine what metrics are available for your CPU
  * ```pcm.exe```
  * ```pcm-*.exe```

Note: Not all commands have --help option, see source code for complete list. ```e.g. pcm-202403\src\Windows\PCMService.cpp```

Example PCM.exe output on i7 12700k on Windows 11 23H2: E-Cores Disabled, HT Disabled, C-States Disabled, Turbo and EIST/Speed Shift Enabled running at ~4.69Ghz.
```
 UTIL  : utlization (same as core C0 state active state residency, the value is in 0..1)
 IPC   : instructions per CPU cycle
 CFREQ : core frequency in Ghz
 L3MISS: L3 (read) cache misses
 L2MISS: L2 (read) cache misses (including other core's L2 cache *hits*)
 L3HIT : L3 (read) cache hit ratio (0.00-1.00)
 L2HIT : L2 cache hit ratio (0.00-1.00)
 L3MPI : number of L3 (read) cache misses per instruction
 L2MPI : number of L2 (read) cache misses per instruction
 READ  : bytes read from main memory controller (in GBytes)
 WRITE : bytes written to main memory controller (in GBytes)
 TEMP  : Temperature reading in 1 degree Celsius relative to the TjMax temperature (thermal headroom): 0 corresponds to the max temperature
 energy: Energy in Joules


 Core (SKT) | UTIL | IPC  | CFREQ | L3MISS | L2MISS | L3HIT | L2HIT | L3MPI | L2MPI |  TEMP

   0    0     0.01   0.81    4.69      69 K     96 K    0.85    0.59  0.0020  0.0028     59
   1    0     0.00   0.55    4.69      23 K     10 K    0.80    0.53  0.0113  0.0049     59
   2    0     0.00   1.15    4.64      79 K     20 K    0.65    0.81  0.0057  0.0015     60
   3    0     0.00   0.63    4.69    4352     4933      0.91    0.56  0.0040  0.0045     59
   4    0     0.04   1.84    4.69     181 K    127 K    0.80    0.75  0.0005  0.0003     56
   5    0     0.00   1.00    4.69     130 K     27 K    0.70    0.80  0.0064  0.0013     58
   6    0     0.01   1.11    4.69     210 K     96 K    0.81    0.75  0.0040  0.0018     58
   7    0     0.00   0.68    4.69      17 K   7838      0.80    0.54  0.0088  0.0039     60
---------------------------------------------------------------------------------------------------------------
 SKT    0     0.01   1.50    4.69     716 K    389 K    0.79    0.73  0.0014  0.0008     56
---------------------------------------------------------------------------------------------------------------
 TOTAL  *     0.01   1.50    4.69     716 K    389 K    0.79    0.73  0.0014  0.0008     N/A

 Instructions retired:  500 M ; Active cycles:  333 M ; Time (TSC): 3647 Mticks ; C0 (active,non-halted) core residency: 0.88 %

 C1 core residency: 99.12 %; C3 core residency: 0.00 %; C6 core residency: 0.00 %; C7 core residency: 0.00 %;
 C0 package residency: 100.00 %; C2 package residency: 0.00 %; C4 package residency: 0.00 %; C6 package residency: 0.00 %;
                             ┌────────────────────────────────────────────────────────────────────────────────┐
 Core    C-state distribution│01111111111111111111111111111111111111111111111111111111111111111111111111111111│
                             └────────────────────────────────────────────────────────────────────────────────┘
                             ┌────────────────────────────────────────────────────────────────────────────────┐
 Package C-state distribution│00000000000000000000000000000000000000000000000000000000000000000000000000000000│
                             └────────────────────────────────────────────────────────────────────────────────┘
---------------------------------------------------------------------------------------------------------------
MEM (GB)->|  READ |  WRITE | CPU energy | PP0 energy | PP1 energy |
---------------------------------------------------------------------------------------------------------------
 SKT   0     0.06     0.02      32.25      30.53       0.00
---------------------------------------------------------------------------------------------------------------
```

## Optional: Install/Uninstall Perfmon Counters Service
Installing and running this service will allow you to capture similar metrics via Perfmon and custom data collector.
* Open CMD.exe or PowerShell as admin
* Install Service: ```C:\Program Files (x86)\PCM\pcm-service.exe -Install```
* Uninstall Service: ```C:\Program Files (x86)\PCM\pcm-service.exe -Uninstall```

* Starting and Stopping the PCM Perfmon Service:
  * ```net start pcmservice```
  * ```net stop pcmservice```

* Using the counters in Perfmon
  * Ensure the service is running, should start on reboot but if not start service manually if just installed.
  * Open Windows Perfmon and go to Data Collector Sets > User Defined
  * Right Click and choose Create new Data Collector Set, give it a unique name, press Next.
  * Choose Advanced and select Performance Counter, press Next.
  * Press the Add button and choose from the available ```PCM *``` performance counters
  * Set desired interval such as 1 second then press Finish.
  * Right click your new data collector set and choose Start, run for the duration of your tests or monitoring.
  * Right click your new data collector set and choose Stop to complete the event collection process.
  * Review your results under ```Perfmon > Reported > User Defined > <Data Collector Set Name> > Report Name```

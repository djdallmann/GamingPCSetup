## Software
### Mousetester
#### Q: What is MouseTester?
MouseTester is a software tool with a graphical user interface created by [microe](https://github.com/microe1) to help analyze various performance characteristics of a peripheral device under test while using the Microsoft Windows operating system. The software was later adapted by another user [dobragab](https://github.com/dobragab) who added their own contributions and features. e.g. MouseTester reloaded. See forum threads of each for more information.

**References**
* MouseTester
   * Code: https://github.com/microe1/MouseTester
   * Forum: https://www.overclock.net/threads/mousetester-software.1535687/
* MouseTester Reloaded
   * Code: https://github.com/dobragab/MouseTester
   * Forum: https://www.overclock.net/threads/mousetester-software-reloaded.1590569/
</br></br>

#### Q: What contributes to variance in MouseTester plots and how can you improve it?
After having used MouseTester on several Windows platforms you may notice that you have either constant or irregular deviations along your graph for the duration of the test, especially on Windows 10 which out of the box has over 100 processes in comparison to some of the predecessors. Several factors contribute to variance in MouseTester plots most of which comes down to how the Microsoft Operating system schedules time for processes and threads to their respective CPU/Cores, the speed at which it can process the data and of course some the underlying architecture of raw input processing. To learn more see findings and analysis below.

<details><summary><ins>Findings and Analysis</ins></summary>

To begin let's first look at how a MouseTester plot looks using an slightly optimized Windows 10 LTSC 2019 (Windows 10, 1809) configuration. Each dot on the plot represents data received from the peripheral device (while in motion) and was then processed and captured by the operating system. In order to reach the desired frequency enough movement must occur to generate data to meet the defined polling rate of the device under test. This is typically done by moving the mouse in circles at a constant rate which is also important for consistent readings.

![Stable Plot](../../DOCS/IMAGES/MouseTester%20%20-%20Optimized%20System.png)
  
**Note:** The system is using an unmodified version of the built-in High Performance Power plan, all [BIOS power saving features](../../DOCS/BIOS/README.md) are turned off, the timer resolution is at the default value, USB controller & devices are **not** set to turn off to save power, the video card (NVIDIA) is using default settings and [running at the highest performance state](../../RESEARCH/WINDRIVERS/README.md#q-is-there-a-registry-setting-that-can-force-your-display-adapter-to-remain-at-its-highest-performance-state-pstate-p0), mouse is a Razer Viper Mini set to 1000hz polling rate.
</br></br>
  
**How does the data travel from the mouse through the Windows operating system?**

![Mouse Data Processing Microseconds View](../../DOCS/IMAGES/MouseTester%20-%20CPU%20Processing%20Chain%20Described.png)
  
Visual from [Microsoft's Media Experience Analyzer (MXA/XA)](../../TROUBLESHOOTING/MEDIAPLAYBACK/README.md#media-experience-analyzer) scheduler view. Y-Axis represents the process/thread priority in the scheduler and the X-Axis is time passed during processing with associated [Ready Threads](https://www.microsoftpressstore.com/articles/article.aspx?p=2233328&seqNum=7#) (lines linked between threads)

**Summary**
1. An interrupt is generated for the device (Interrupt Service Routine aka ISR) (green square, upper left corner)
2. The work (data processing) is then deferred for processing (Deferred Procedure Call aka DPC) by the driver (USB XHCI [KMDF driver](https://docs.microsoft.com/en-us/windows-hardware/drivers/wdf/kernel-mode-driver-framework-architecture) WDF01000.sys)
3. DPC is processed
5. The [Client/Server Runtime Subsystem (CSRSS)](../../RESEARCH/WINSERVICES/README.md#clientserver-runtime-subsystem-csrss) processes the raw input events (keyboard/mouse)
6. CSRSS is then responsible to exchange the information with both subscribing services Windows Desktop Manager (DWM) and MouseTester.exe.
7. DWM and the MouseTester process the information on the screen such as requesting the graphics adapter to render the cursor on the screen or write the data to memory for further review.
</br></br>

**What can we learn and use from this information?**
* This ultra small sample took 134us (microseconds) from start to end to process data (upper right corner of screenshot, red square). ~120us of which were spent in CSRSS, DWM and MouseTester.exe
* Time diverted away from these threads, drivers, and processes impact their ability to provide/capture information as quickly as possible.
   * These are usually spikes/variations in plots, or consistent variations along the main distribution.
* Ensure each of these drivers, processes and threads gets as much uninterrupted time as possible. (Depends, see below and read MS references on scheduling, processes and threads)
* Reduce time taken where possible by processes, their threads and drivers in general. e.g. Code optimization, process/thread configuration, driver parameters.
</br></br>

**What I found to provide the most consistent results**
   * WDF01000.sys
      * Bind the USB XHCI Controller to a single dedicated core which is not shared or underutilized by other drivers (ISR/DPC), processes and threads. e.g. Use core 5 of 8
   * DWM and CSRSS
      * Put these on the same core (affinity), if separated you'll likely get outliers consistently at 1005 or 1010Hz but nearly stable 1000hz otherwise. They work closely together so putting them on separate cores cause the other CPU to be initiated to process the information vs remaining on the same core. e.g. Use core 8/8.
      * Increase CSRSS priority class from Normal to High to more closely align with DWMs default priority class.
   * MouseTester.exe
      * Use a dedicated core, one may work better than the other unless you have very tight control of **all threads, drivers and processes affinity**. Putting this on the same core as DWM and CSRSS created worst plots as they fought for CPU time. Changing the affinity from high to realtime may also improve your results.

**References and Tools**
* [The Microsoft Press Store by Pearson - Processes, Threads, and Jobs in the Windows Operating System](https://www.microsoftpressstore.com/articles/article.aspx?p=2233328&seqNum=7#)
* [Windows Internals 7th ed](https://www.amazon.ca/Windows-Internals-Part-architecture-management/dp/0735684189)
   * This is probably the book you want to read if you want to learn more about Windows behind the scenes.
* [Process Hacker](https://processhacker.sourceforge.io/)
   * For changing affinities/priorities of privileged processes (CSRSS etc)
* [Microsofts Interrupt_Affinity_Policy_Tool](https://docs.microsoft.com/en-us/previous-versions/windows/hardware/download/dn550976(v=vs.85)?redirectedfrom=MSDN)
   * For assisting with USB XHCI Controller affinity (WDF01000.sys driver DPC/ISR affinity), this can be achieved manually as well.
   * https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/interrupt-affinity-and-priority
* [Microsoft's Media Experience Analyzer (MXA/XA)](../../TROUBLESHOOTING/MEDIAPLAYBACK/README.md#media-experience-analyzer)
* [Microsoft's Windows Performance Analyzer](../../TROUBLESHOOTING/MEDIAPLAYBACK/README.md#media-experience-analyzer)

</details></br>

## Windows Services
### Multimedia Class Scheduler Service (MMCSS)
#### Q: What is Multimedia Class Scheduler Service (MMCSS)?
MMCSS has been a part of the Microsoft Windows operating system for quite a while and was originally designed to improve time sensitive processing for multimedia applications by ensuring those processes/threads get the cpu time they need while still allowing lower priority applications to function. Developers can register their application threads with MMCSS under a customizable set of multimedia Task groups which define what type of priority and cpu resources they should receive.
<details><summary>Findings and Analysis</summary>

* **For more complete information see the official docs page:**
  * https://docs.microsoft.com/en-us/windows/win32/procthread/multimedia-class-scheduler-service

* **Default Multimedia Task Groups:**
  * Audio
  * Capture
  * Distribution
  * Games
  * Playback
  * Pro Audio
  * Window Manager
  
</details></br>

#### Q: Is it possible to tell what processes register to MMCSS and can you determine which tasks they requested?
Yes, you can capture quite a bit of detail about MMCSS activities by capturing the MMCSS ETW trace provider with a tool such as **xperf or Windows Performance Analyzer and Recorder** such as what processes requested MMCSS, the requested task (e.g. Audio, Pro Audio), information about the sleep cycle/system responsiveness and when MMCSS has boosted or adjusted a processes priority and to what value.
<details><summary>Findings and Analysis</summary>

* Quite a bit of information can be learned about how MMCSS functions and that information can be collected and analyzed with it's MMCSS ETW trace provider such as when MMCSS has chosen to boost the priority of a process, and to what value, what multimedia task group was selected, the idle/sleep cycles (lazy or **no lazy** function). This information and those such as context switchs, cycle and frequency analysis, it may be possible to optimize the values for a given scenario or your computer to improve overall responsiveness and efficiency.

1. Download Windows Assessment and Deployment Kit (Windows ADK) - https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install
2. Only **install Windows Performance Analyzer** toolset
3. Using xperf or a custom Windows Performance Recorder (WPR) profile, start a trace for the **Microsoft-Windows-MMCSS ETW trace provider**
   * https://docs.microsoft.com/en-us/windows-hardware/test/wpt/xperf-command-line-reference
   * https://docs.microsoft.com/en-us/windows-hardware/test/wpt/querying-providers
   * https://docs.microsoft.com/en-us/windows-hardware/test/wpt/author-a-custom-recording-profile
4. Start using different applications and games, or perhaps play a YouTube video in your favorite browser.
5. Stop the trace
6. Open the trace in Windows Performance Analyzer
7. Go to **System Activity** and double click **Generic Events, Activity by Provider, Task and Opcode**
8. Filter on the Microsoft-Windows-MMCSS provider and review the different MMCCS events, tasks and state details.

![winservices_MMCSSETW_WPADetailSummary](https://github.com/djdallmann/GamingPCSetup/blob/master/RESEARCH/FINDINGS/winservices_MMCSSETW_WPADetailSummary.png)

</details></br>

#### Q: What types of MMCSS tasks are requested by common applications?
The most commonly requested task is Audio, this will occur naturally when Windows applications make requests to Microsofts High Level Apis for Audio playback. Browsers based on Chromium such as the new Microsoft Edge and the Google Chrome browser use **Pro Audio**. See findings and analysis for other common processes including some old and modern games.
<details><summary>Findings and Analysis</summary>

* Below is a basic list of common processes including some new and old games and the MMCSS tasks they register under:
  * msedge.exe (Chromium) - **Pro Audio**
  * audiodg.exe - **Audio**
  * q3.exe - **Audio**
  * hl.exe - **Audio**
  * chrome.exe (Chromium) - **Pro Audio**
  * firefox.exe - **Audio**
  * vlc.exe - N/A
  * steamwebhelper.exe (Chromium) - **Pro Audio**
  * csgo.exe - **Audio**
  * consent.exe - **Audio** (seems odd but ok, perhaps inheritance)
  * dwm.exe - *By default none*, even during early boot process. See other Q & A for more info on when it uses MMCSS.
  * csrss.exe - *By default none*, even during early boot process. See other Q & A for more info on when it uses MMCSS.
  * fortnite client/game - **Audio**
  * r5apex.exe - **Both Audio and Pro Audio**
  * taskhostw.exe - **Audio**
  
**Note:** Keep in mind that the requests to MMCSS are typically only for threads which process audio, to date I have not yet confirmed any threads are associated to input or graphics processing.
</details></br>

#### Q: Does CSRSS.exe (Client/Server Run-Time Subsystem) or DWM.exe (Desktop Window Manager) ever use MMCSS?
Not by default or without user intervention but... there is a DWM api function call which you can use to allow DWM/CSRSS to opt into MMCSS. See findings and analysis for more information.
<details><summary>Findings and Analysis</summary>

* Both Desktop Window Manager (DWM) and Client/Server Run-Time Subsystem (CSRSS) do not register with MMCSS at anytime without user intervention or the use of the DWM API DwmEnableMMCSS function, when this function is used they register under the following multimedia task groups.
  * **MMCSS Task Groups:**
    * dwm.exe - Window Manager AND Capture
    * csrss.exe - Capture
 
![winservices_DWMCSRSS_mmcsstask](https://github.com/djdallmann/GamingPCSetup/blob/master/RESEARCH/FINDINGS/winservices_DWMCSRSS_mmcsstask.png)

* Microsoft Docs Reference: DwmEnableMMCSS function (dwmapi.h)
  * https://docs.microsoft.com/en-us/windows/win32/api/dwmapi/nf-dwmapi-dwmenablemmcss

</details></br>

#### Q: Do any processes or threads register with MMCSS during the boot process?
No threads or process have been observed using MMCSS during the boot process.
<details><summary>Findings and Analysis</summary>
No
</details></br>

#### Q: Do any processes or threads register with MMCSS task DisplayPostProcessing?
No threads or process have been observed using this MMCSS task both during runtime or the boot process.
<details><summary>Findings and Analysis</summary>
No
</details></br>

#### Q: Do any processes or threads register with MMCSS task Games?
No threads or process have been observed using this MMCSS task in both old or new games.
<details><summary>Findings and Analysis</summary>
No
</details></br>

#### Q: What the heck is NoLazyMode, is it real? What does it do?
Yes, NoLazyMode is a real MMCSS setting which can be seen through registry key access monitoring and is also identified by extracting strings from mmcss.sys (driver). Current analysis suggests that the MMCSS scheduler sleep cycle and idle detection are different when enabled vs disabled. See findings and analysis for more details.
<details><summary>Findings and Analysis</summary>

* The NoLazyMode MMCSS registry key has been floating around the web although no conclusive evidence or measurement has been given surrounding it's use nor does it have any official documentation by Microsoft. 
* Based on early analysis of MMCSS ETW trace provider setting the DWORD value to 0x1 (Default: 0, Disabled/Non-Present) changes the MMCSS scheduler sleep/idle behavior.
* The screenshot below demonstrates some of the initial differences between each mode enabled (0x1) vs off (x0, Non-Present), during these tests MMCSS tasks were engaged and the same pattern reoccurred each time e.g. the Idle related conditions were no longer present leaving only **System Responsiveness, Deep Sleep and Realtime** MMCSS scheduler task results.

![winservices_MMCSS_nolazymode_onvsoff](https://github.com/djdallmann/GamingPCSetup/blob/master/RESEARCH/FINDINGS/winservices_MMCSS_nolazymode_onvsoff.png)

* At this time it is assumed that when NoLazyMode is enabled (DWORD: 0x1) it likely uses more cycles and becomes more aggressive by reducing idling/sleeping and operates in a more realtime mode. 
* This can also be validated by context switch, cycle, frequency and cpu usage analysis which may come at a later date to help determine if the setting has any positive influence.

**Registry Key Path:**
```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile
"NoLazyMode"=dword:00000001
```

</details></br>

#### Q: What does the hidden MMCSS Latency Sensitive registry key actually do? What is the default value?
Latency Sensitive refers to Latency Sensitive Hints, essentially under cpu heavy conditions MMCSS can create latency sensitive hints to the processor power performance engine to help adjust performance state (PoLatencySensitive). When this condition occurs we see **TurboEngaged** events in MMCSS provider event audit and corresponding Latency Sensitive Hints from SYSTEM in the Windows Kernel Power Provider.
<details><summary>Findings and Analysis</summary>
 
* Latency Sensitive refers to Latency Sensitive Hints, essentially under heavy cpu use MMCSS can create latency sensitive hints 
to the processor power performance engine to help adjust performance state (PoLatencySensitive). When this condition occurs we see **TurboEngaged** events 
in MMCSS provider event audit and corresponding Latency Sensitive Hints from SYSTEM in the **Windows Kernel Power Provider.**

![MMCSS.sys Latency Sensitive](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/MMCSS.sys%20-%20Latency%20Sensitive.PNG)

* The **default value of Latency Sensitive is TRUE** at least on Windows 10, in order to set this to FALSE in MMCSS globally it must be added to all tasks.
* Adjusting the values in the hidden power plan settings increases the frequency of those Latency Sensitive Hints for MMCSS tasks by 
lowering the threshold and response for those scenarios. The documentation and impact of changing these settings seems sparse
so I cannot recommend changing these values at this time but it is noteworthy, these settings impact the entire system. 
On a similar note the Client/Server Runtime Subsystem (CSRSS) process is continually generating latency sensitive hints on my computer
likely since its performance is directly tied to user experience and many components on the windows system including raw input interface 
between kernel and user space for mouse and keyboard. There also appears to be different types of Latency Sensitive Hint Types according to the event trails.
 
To unhide those values in the current power plan:
```
powercfg -attributes SUB_PROCESSOR 619b7505-003b-4e82-b7a6-4dd29c300971 -ATTRIB_HIDE
powercfg -attributes SUB_PROCESSOR 619b7505-003b-4e82-b7a6-4dd29c300972 -ATTRIB_HIDE
```

Related Power Options:
   * https://docs.microsoft.com/en-us/windows-hardware/customize/power-settings/options-for-perf-state-engine-perflatencyhint
   
Registry Key Path:
```
HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MultiMedia\systemprofile\Tasks\<TASKNAME>\
String Value: Latency Sensitive
Values: True or False
```
</details></br>

#### Q: Does the MMCSS task Clock Rate registry setting do anything?
Firstly no, I haven't found any evidence that this setting has any impact which aligns with Microsofts Documentation but it can... yes I know very click baity. See findings and analysis for more information.
<details><summary>Findings and Analysis</summary>
 
* During my tests of manipulating the Clockrate MMCSS task registry value it had no impact on MMCSS cycles, timer resolution or anything else I could think of at the time, Microsofts documentation states specifically **Starting with Windows 7 and Windows Server 2008 R2, this guarantee was removed to reduce system power consumption.** which seems to align with everything I checked.
* There is one issue though which actually applies to MANY of the MMCSS task registry settings and parent keys, and that is **if you set a value too high (above 10,000 the default in this case), too low (~2,000, not sure of exact range tried a few) that MMCSS task will cease to function** while others will continue to work and receive boosts, this effectively creates a way of having MMCSS run while blocking certain MMCSS tasks. I will make a specific entry in this research page for other settings, examples and what impacts it could have.
* On the last bullet point, this might explain why people say they can feel a difference changing the Clock Rate registry setting and that is because the MMCSS task completely ceases to function.
</details></br>

#### Q: What is the BackgroundPriority mmcss registry setting? Does it have anything to do with the Background Only registry key?
The BackgroundPriority registry key influences the **Base Thread priority** when the **Scheduling Category is Low**, and has no direct relation to the Background Only registry key. See findings and analysis for more information.
<details><summary>Findings and Analysis</summary>
 
* During my analysis of different MMCSS tasks Audio and Pro Audio, the Background Only registry key value (True or False) had no direct relationship to the BackgroundPriority value. 
* When the **Scheduling Category is LOW, the base priority of the thread is not influenced by the tasks Priority setting**. When set to LOW the thread has a base value of 8, incrementing BackgroundPriority (default is 1) will boost the base priority giving you a maximum base priority of 15 (just before REALTIME 16 priority class).

**Thread Base Priority to BackgroundPriority Mapping**
| BackgroundPriority  | Thread Base Pri |
| ------------- | ------------- |
| 1  | 8  |
| 2  | 9  |
| 3  | 10 |
| 4  | 11 |
| 5  | 12 |
| 6  | 13 |
| 7  | 14 |
| 8  | 15 |

As noted above, this only applies when Scheduling Category is LOW.

 </details></br>
 
#### Q: Does the hidden MMCSS SystemProfile registry setting LazeModeTimeout alter the running state?
Yes, this value does in fact alter the settings in the MMCSS Scheduler sleep cycle for idle time periods related to  the events **IdleDetectionLazy** and **SleepRealtimeLazy**.
<details><summary>Findings and Analysis</summary>

* This one was pretty easy to confirm, I changed the value then compared it to what MMCSS event provider was recording. This value alters the lazy sleep timeout periods globally, more information on what impact this has on the MMCSS scheduler in another MMCSS research article.

   ![MMCSS.sys - LazyModeTimeout](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/MMCSS.sys%20-%20LazyModeTimeout.PNG)
</details></br>

#### Q: Does the hidden MMCSS SystemProfile registry settings MaxThreadsTotal and MaxThreadsPerProcess restrict overall use of MMCSS?
Unfortunately this has zero impact on how many threads total or per process that could register with MMCSS during multiple tests, see findings for more information.
<details><summary>Findings and Analysis</summary>

* For the evaluation of these settings I set each to different combinations of 1 and 3 (e.g. 3&1, 1&3, 3&3, 1&1) then I proceeded to generate MMCSS tasks for both Pro Audio and Audio, both separately and together. The simplest way to generate multiple threads for under a single process **under normal circumstances** is to open a browser such as Chrome then load a bunch of YouTube videos let's say 6 and ensure they are all playing media simultaneously, and in this scenario it had no impact on the number of threads registered to MMCSS under the Chrome browser process in relation to **MaxThreadsPerProcess** setting. 
  * Its hard to say if this particular test is ideal but it was the quickest way to test, the reason being is that Chrome is a single parent process but for each tab child processes are created. Perhaps if it was a single parent process and I tried registering multiple threads in that process it may change the outcome. 
  * I don't feel like writing custom code to test but if someone's interested in recreating the test and capturing the result please let me know.

* A similar test was done however in relation to **MaxThreadsTotal**, the assumption of this setting is to globally restrict the total amount of threads that can register with MMCSS, in all tests the total threads registered in MMCSS were not restricted in those scenarios.

</details></br>

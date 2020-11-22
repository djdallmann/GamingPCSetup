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
  * ShellExperienceHost.exe - **Audio**
  
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
 
#### Q: Does the hidden MMCSS SystemProfile registry setting LazyModeTimeout alter the running state?
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

#### Q: Does the MMCSS task registry setting SFIO Priority actually change the IO Priority or does it do nothing like Microsoft's documentation states?
Microsoft's documentation is spot on again, the value of this registry setting does not influence IO Priority of the MMCSS registered thread.
<details><summary>Findings and Analysis</summary>
 
* Microsofts documentation for MMCSS states the following and is again it's spot on.
  * SFIO Priority	REG_SZ	The scheduled I/O priority. This value can be set to Idle, Low, Normal, or High. **This value is not used.**
* To test if this value had any impact I changed the setting for each scenario to one of the expected values **Idle, Low, Normal, and High** and ensured that MMCSS driver was restarted to re-read the new configuration from the registry. Kicked off a new capture of the MMCSS provider and launched some multimedia applications then let it run for a bit and  stopped the capture. With the multimedia applications still running I reviewed the MMCSS provider information and found the associated Thread ID and analyzed the associated thread properties using Microsoft Windows Sysinternals Process Explorer and **observed that the IO Priority was not influenced in any scenario**.

</details></br>

#### Q: How does MMCSS map the defined priorities and scheduling category in relation to the values recorded by the event provider?
When a thread joins MMCSS it reads the registry for the specified tasks and maps those values to three different priority levels **Medium, Low and Uber Low** under the given Scheduling Category. For more information see findings and analysis, and associated priority mapping table reference.
<details><summary>Findings and Analysis</summary>
 
Based on those values (**Medium, Low and Uber Low**) and the scheduling category MMCSS has it's own internal mapping which is reflected in the boosted priority and a deprioritization value. The **Medium value reflects the boosted value** give or take +1 (not exactly intuitive but probably done this way for a reason, you'll see..) , the **Low value only applies for Scheduling Category Low** then **Uber Low reflects the deprioritzation value.**

The values are pretty consistent between the Scheduling Category Medium and High as you'll note when analyzing the table below. However when the scheduling category is Low things aren't exactly as they seem and I have seen some variation in the outcome which I'll note below. **When using Low the process is never deprioritized**, this is likely because the kernel will typically handle processes priority management outside of the realtime range (16+), on the same note only the processes intial priority value is set and **not boosted again**, at least during my analysis.

**Scheduling Category: High**
  * Intended range: 23-26
  * Actual range: 26
  
| Conf. Priority  | Medium Pri | Low Pri  |  Uber Low Pri | MMCSS Boost Pri  | MMCSS Deprioritization | 
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | 
| 8  | 24 | 8  | 7  | 26  | 7  |
| 7  | 24 | 8  | 6  | 26  | 7  |
| 6  | 24 | 8  | 5  | 26  | 7  |
| 5  | 24 | 8  | 4  | 26  | 6  |
| 4  | 24 | 8  | 3  | 26  | 5  |
| 3  | 24 | 8  | 2  | 26  | 4  |
| 2  | 24 | 8  | 1  | 26  | 3  |
| 1  | 24 | 8  | 1  | 26  | 2  |

**Scheduling Category: Medium**
  * Intended range: 16-22
  * Actual range: 17-23
  
| Conf. Priority  | Medium Pri | Low Pri  |  Uber Low Pri | MMCSS Boost Pri  | MMCSS Deprioritization | 
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | 
| 8  | 23 | 8  | 7  | 23  | 7  |
| 7  | 22 | 8  | 6  | 23  | 7  |
| 6  | 21 | 8  | 5  | 22  | 6  |
| 5  | 20 | 8  | 4  | 21  | 5  |
| 4  | 19 | 8  | 3  | 20  | 4  |
| 3  | 18 | 8  | 2  | 19  | 3  |
| 2  | 17 | 8  | 1  | 18  | 2  |
| 1  | 16 | 8  | 1  | 17  | 1  |

**Scheduling Category: Low**
  * Intended range: 8-15
  * Actual range: **It depends..**, see both tables and narrative

| Conf. Priority  | Medium Pri | Low Pri  |  Uber Low Pri | MMCSS Boost Pri  | MMCSS Deprioritization | 
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | 
| 8  | 8 | 8  | 7  | 8  | None  |
| 7  | 8 | 8  | 6  | 8  | None  |
| 6  | 8 | 8  | 5  | 8  | None  |
| 5  | 8 | 8  | 4  | 8  | None  |
| 4  | 8 | 8  | 3  | 8  | None  |
| 3  | 8 | 8  | 2  | 8  | None  |
| 2  | 8 | 8  | 1  | 8  | None  |
| 1  | 8 | 8  | 1  | 8  | None  |

With Scheduling Category set as Low I recevied two different results when comparing for example audiodg and Chrome, Chrome's task (Pro Audio) base priority never changes from 10 regardless of settings so this is likely due to the way the application was coded. However audiodg will use the default base priority of 8 using the **normal Priority** values, and then **only using Background Priority will it actually boost the base priority** as indicated below.

**Scheduling Category: Low and Background Priority**
  * Intended range: 8-15
  * Actual range: 8,9,11-15
  
| Conf. BG Priority  | Medium Pri | Low Pri  |  Uber Low Pri | MMCSS Boost Pri  | MMCSS Deprioritization | 
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | 
| 8  | 8 | 8  | 8  | 15  | None  |
| 7  | 8 | 8  | 7  | 14  | None  |
| 6  | 8 | 8  | 6  | 13  | None  |
| 5  | 8 | 8  | 5  | 12  | None  |
| 4  | 8 | 8  | 4  | 11 | None  |
| 3  | 8 | 8  | 3  | 9  | None  |
| 2  | 8 | 8  | 2  | 8  | None  |
| 1  | 8 | 8  | 1  | 8  | None  |  
  
 </details></br>
 
#### Q: Does the MMCSS AlwaysOn registry setting exist?
Yes, there does appear to be an MMCSS **AlwaysOn** registry setting in **both Windows 7 and Windows 8** but it does not exist in Windows 10. This may related to the fact that MMCSS is a driver in Windows 10 where as it is a service integrated in svchost.exe on older versions. The purpose of this registry key is currently unknown, if anyone has any evidence of its impact and use let me know.

</br>

#### Q: What's actually happening inside MMCSS on a millisecond time scale? What variables are there and how do they come into play?
There's a handful of events that are happening inside MMCSS, here's a breakdown of those events:
  * **Thread Joins** - Occurs when a thread registers with MMCSS and indicates which task it selected
  * **Scheduler Priority Change** - Priority is increased or decreased
  * **TaskIndex_PreDeadlineExpired** - Indicates a yield deadline has expired, occurs just before Scheduler Wakeup
  * **Scheduler Wakeup** - Occurs when a yield deadline is reached
  * **Scheduler Sleep** - Indicates when the scheduler sleeps, the type of sleep and duration.
  * **Set_MultimediaMode and Thread Buffering** - Likely signals kernel streaming
  * **TaskIndex_Yield** - Summarizes the yield period duration

To learn more about MMCSS behavior, potential gotchas, and variables then see findings and analysis.
<details><summary>Findings and Analysis</summary>
 
To explain what MMCSS is doing it's best to use an example so in this case we'll assume the following: 
* We have a **default MMCSS system profile and task settings**
* Using the Chromium based Microsoft Edge browser we'll play a YouTube video

**Note:** audiodg.exe is required for media playback so it'll always have a thread join event as a result **there will always be a minimum of 2 mmcss task threads** in most circumstances.

![MMCSS.sys - Millisecond Scale](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/MMCSS.sys%20-%20Millisecond%20Scale.png)

In the following table time represents the actions performed during each millisecond:
| Time  | Event | Description |
| ------------- | ------------- | ------------- |
| 1ms | MMCSS Initialization of first registered threads | N/A |
| 1ms | Thread Joins | A MMCSS Pro Audio task is registered (Index00001 - msedge.exe) |
| 1ms | Scheduler Priority Change | MMCSS boosts the thread (Index00001 - msedge.exe) to the defined value in Pro Audio e.g. Sched Cat: High, Pri: 2, Priority 26 (Realtime) |
| 1ms | Scheduler Wakeup | Returns from a **DeepSleep state** |
| 1ms | Scheduler Sleep | Enters the realtime sleep state |
| 1ms | Thread Joins | A MMCSS Audio task is registered (Index00002 - audiodg.exe) |
| 1ms | Scheduler Priority Change | MMCSS boosts the thread (Index00002 - audiodg.exe) to the defined value in Audio e.g. Sched Cat: Medium, Pri: 6, Priority 22 (Realtime) |
| 2ms | Set_MultimediaMode (1 then 0), Thread Buffering (Start then Stop) | Toggles two functions briefly, usually only seen upon initialization of MMCSS |
| 2ms | TaskIndex_Yield | TaskIndex Index00002 (audiodg.exe) has yielded for X |
| 2ms | Scheduler Priority Change | Deprioritizes task TaskIndex Index00002 (audiodg.exe) to 16. |
| [...] | **~10ms passes** | The thread yields and service is in an Idle detection sleep state, **when this happens only audiodg.exe is boosted** 22 to 16, 16 to 22 (Audio Task) |
| 11ms | Scheduler Priority Change | MMCSS boosts the thread (Index00002 - audiodg.exe) to 22 |
| 11ms | TaskIndex_PreDeadlineExpired | TaskIndex Index00002 (audiodg.exe) predeadline has passed. |
| 11ms | Scheduler Wakeup | New thread yield deadline |
| 12ms | TaskIndex_Yield | TaskIndex Index00002 (audiodg.exe) yield complete |
| 12ms | Scheduler Priority Change | Deprioritizes task TaskIndex Index00002 (audiodg.exe) to 16. |
| [...] | **~10ms passes** | Yield and Idle detection |
| 22ms | Scheduler Priority Change | MMCSS boosts the thread (Index00002 - audiodg.exe) to 22 |
| 22ms | TaskIndex_PreDeadlineExpired | TaskIndex Index00002 (audiodg.exe) predeadline has passed. |
| 22ms | Scheduler Wakeup | Yield Deadline |
| 23ms | TaskIndex_Yield | TaskIndex Index00002 (audiodg.exe) yield complete |
| 23ms | Scheduler Priority Change | Deprioritizes task TaskIndex Index00002 (audiodg.exe) to 16. |
| [...] | Cycle repeats |  If Idle Detection identifies activity. **When tasks priorities are updated they are done in the order of the index** e.g. 00001, 00002, 00003. |
| 200ms | Idle detection | Finally realizes you're there and begins prioritizing things according to **SystemResponsiveness** |
| 200ms | Scheduler Priority Change | **Deprioritizes** each tasks based on their config mapping |
| 200ms | Scheduler Sleep | IdleDetection (Default 10ms) or IdleDetectionLazy (Default 100ms), will explain this after |
| 202ms | Scheduler Wakeup | Yield Deadline |
| 202ms | Scheduler Priority Change, **2ms passes** | **MMCSS boosts priority of all mmcss threads**, also **note 2ms has passed** during the deprioritized state and that systemresponsiveness is 20 by default, e.g. 2ms and 8ms |
| [...] | **8ms passes** in a boosted state | N/A |
| 210ms | Scheduler Priority Change | Deprioritizes each tasks based on their config mapping |
| 210ms | Scheduler Sleep | IdleDetection (Default 10ms) or IdleDetectionLazy (Default 100ms) |
| 211ms | Scheduler Wakeup | Yield Deadline |
| 211ms | Scheduler Priority Change | MMCSS boosts all the threads |
| [...] | Cycle repeats | **If you are detected as not Idle all task threads boost**, otherwise if idle state is detected only audiodg.exe is boosted like in the beginning, more details on Idle detection below |

And there you have it, a general overview of what happens inside MMCSS and now we get into IdleDetection and IdleDetectionLazy...

**Idle Detection and IdleDetectionLazy**

Idle detection doesn't seem to work the way you think it might, it doesn't appear to be based on the fact that you're constantly playing media but perhaps related to other methods such as user input or indicators. 

Based on my analysis this is how IdleDetection works and how it can get into similar states where no mmcss prioritization occurs** although the user is actively playing game or playing media. First off **IdleDetection** is done roughly on 10ms periods (value 100,000, **100 nanosecond intervals**) and if it doesn't detect any activity it shifts into **IdleDetectionLazy** mode which operates at 100ms periods (value 1,000,000, 100 nanosecond intervals). When activity isn't detected **on** the 100ms interval, it goes into another 100ms period which seems to easily chain into many lazy cycles for **20 seconds or more** leaving threads in a potentially **suboptimal state**. When IdleDetectionLazy occurs only audiodg.exe is prioritized and deprioritized as indicated above.

Luckily you can alter how MMCSS IdleDetection and IdleDetectionLazy states operate by fine tuning a few hidden variables, **NoLazyMode and LazyModeTimeout**. NoLazyMode will outright disable IdleDetection for the most part however it **may** be more resource intensive, alternatively you can change the LazyModeTimeout 100ns interval by adding and setting the hidden registry key value.

```
LazyModeTimeout Default: 1,000,000 (100ms), is a 100 nanosecond interval.
Example: 10,000 (1ms)
HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MultiMedia\systemprofile\LazyModeTimeout DWORD (32bit) : 10000

NoLazyMode Default: 0 (Off)
Optional: On
HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\MultiMedia\systemprofile\NoLazyMode DWORD (32bit) : 1
```

**List of values for scheduler sleep:**
*	SleepRealtimeLazy: 1,000,000 (100ms)
*	IdleDetectionLazy: 1,000,000 (100ms)
*	IdleDetection: 100,000 (10ms)
*	Realtime 80,000 (8ms)
*	SleepResponsiveness 20,000 (2ms)
*	DeepSleep: 4,294,967,295

**System Responsiveness**

After having gone through the example above you may note that this setting is a literal translation of time, **2ms (20) for low priority tasks** and **8ms, the remainder** for mmcss registered tasks in their boosted priority states when using the default systemresponsiveness setting. On that note you should also keep in mind those same threads are still using quite a bit of cpu time in a lower priority state but... when the threads are below priority 16 (realtime) the kernel can give more attention to those other threads by shifting their priorities as needed.

</details></br>

#### Q: What happens when you set SystemResponsiveness to a value higher than 50?
When MMCSS SystemResponsiveness is set to values above 50 (e.g. 60, 70, 80 & 90) audiodg.exe will register a thread with MMCSS and leave immediately after, following this only the games registered thread will be boosted. Thank you plumch who reported this on discord.

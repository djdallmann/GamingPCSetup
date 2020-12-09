# Identifying Disk Bottlenecks
## Using Windows Built-in Performance Monitor
### Creating your Performance Counters
1. Open **Windows Performance Monitor**, using Search in the windows taskbar locate and open the built-in Performance Monitor.
2. On the left hand menu go to **Data Collector Sets** then **User Defined**, right click and choose **New -> Data Collector Set**
   * Give it a **name** e.g. My Disk Counters
   * Choose **Create manually (Advanced)** then press Next
   * Ensure to select **Performance counter** then press Next
   * Lower the sample interval to **3 seconds**
   * Press **Add** to start including the necessary counters
3. Add the following counters:
   * Under **Logical Disk** add the following counters for **Instance -> C:** or other drive volume you are troubleshooting
     * **% Free Space**
     * **Avg. Disk Queue Length**
     * **Avg. Disk sec/Read**
     * **Avg. Disk sec/Write**
     * **Disk Transfers/sec**
   * Under **Process** add the following counters for **Instances -> <All_instances>**
     * **IO Read Operations/sec**
     * **IO Write Operations/sec**
4. Press **OK** to finish adding the counters then press **Next**, if you have more than one disk you may want to consider writing your data set to another drive not to skew the results by writing to the same disk you are analyzing.
5. Press **Next** then **Finish** to complete the process.
6. To start recording data in your data collector set, right-click **My Disk Counters** and choose **Start**.

Start recording your data set when trying to isolate disk io bottleneck issues before running a particular program, or if the issue is intermittent you could choose to start the counter at anytime with minimal impact then review the data after your session. **Make note of the time(s) you believe you experienced a performance problem.**
   
### Identifying Bottlenecks
#### Disk Latency - Primary Indicators
* Related Counters
  * **Avg. Disk sec/Read**
  * **Avg. Disk sec/Write**
  
1. Navigate to the folder where you chose to store your Data Collector Set, double click to open in Windows Perfmon for analysis.
2. **Select** the time period you believe you experienced a performance problem, look at the **Average** and **Maximum values** for the selected period. Those numbers are represented as **0.0NN where 0.040 represents 40ms**.
3. On a higher performance disks such as SSD or disks in RAID0 you'll likely get **Averages around 0.003 (0.3ms) or lower** depending on the type load for both (read/write), ideally you'd want these values as low as possible. If you are seeing **higher values (15-20ms)** then you have a disk I/O bottleneck then continue the **secondary indicators**. Bottlenecks could suggest the disk is not fast enough for the current processing load causing increased wait times, there could also be a driver or software issue causing inefficient use.

#### Disk Latency - Secondary Indicators
TBC

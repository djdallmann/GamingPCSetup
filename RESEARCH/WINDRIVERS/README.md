## Windows Drivers
### Keyboard and Mouse
#### Q: What are the default non-paged pool allocations for mouclass.sys and kbdhid.sys \*dataqueuesize parameters indicated by the mouclass and kbdclass event providers?
The default non-page pool allocation for keyboarddataqueuesize is **1200 bytes** and mousedataqueuesize **2400 bytes**. The value of mousedataqueuesize is the value specified in the registry multiplied by the size of the structure **MOUSE_INPUT_DATA (24 bytes)** defined in NTDDMOU.H, 100 x 24 = 2400. Similarly for the keyboarddataqueue size it is the value specified in the registry multiplied by the size of the structure **KEYBOARD_INPUT_DATA (12 bytes)** defined in NTDDKBD.H, 100 x 12 = 1200. 

<details><summary>Findings and Analysis</summary>

![KBDCLASS and MOUCLASS default dataqueuesize](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/KBDCLASS%20and%20%20MOUCLASS%20default%20dataqueuesize.png)

**Registry Paths:**
* **HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\kbdclass\Parameters\KeyboardDataQueueSize**
  * Default Value: 100 (0x64)
* **HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\mouclass\Parameters\MouseDataQueueSize**
  * Default Value: 100 (0x64)
  * This setting is not present in registry by default on Windows 10

References:
* https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/keyboard-and-mouse-hid-client-drivers
* https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/keyboard-and-mouse-class-drivers
* https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/ps-2--i8042prt--driver
* https://docs.microsoft.com/en-us/windows/win32/api/ntddmou/ns-ntddmou-mouse_input_data
* https://docs.microsoft.com/en-us/windows/win32/api/ntddkbd/ns-ntddkbd-keyboard_input_data

</details></br>

#### Q: How do the values in keyboarddataqueuesize and mousedataqueuesize affect the non-page pool memory allocation? How can you tell?
These values specify the driver's internal buffer size in nonpaged memory pool for each device object registered to the system, these buffers are dynamically allocated and removed when you connect/disconnect USB devices.
Microsoft provides a tool called **poolmon** as part of the **Windows Driver Kit (WDK)** which let's you see the page and non-paged pool driver memory allocations as they are used and processed, you could also see similar changes with a Windows Performance Analyzer and Recorder capture. See findings and analysis for more information.

<details><summary>Findings and Analysis</summary>

Using poolmon you can view the total allocated buffer space by each driver for the connected devices, in the image below there is one physical Mouse connected and one physical Keyboard using the default values. 

In this case there are two keyboard devices registered (**HID Keyboard Device** in device management), one that is part of the mouse and the keyboard itself which results in a value that is rougly 2400 bytes (1200 x 2) buffer space allocation and the remaining space likely allocated to some regular device object structure.

Then we see similar behavior for the mouse, again there is one **Mice and other pointing devices registered** (HID-compliant mouse) which results in a value that is rougly 2400 bytes (2400 x 1) and another set of bytes related to some other data structures.

![KBDCLASS and MOUCLASS non-paged pool allocation](https://github.com/djdallmann/GamingPCSetup/blob/master/IMAGES/KBDCLASS%20and%20MOUCLASS%20non-paged%20pool%20allocation.png)

</details></br>

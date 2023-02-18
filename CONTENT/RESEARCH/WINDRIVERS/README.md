## Windows Drivers
### Keyboard and Mouse
#### Q: What are the default non-paged pool allocations for mouclass.sys and kbdclass.sys \*dataqueuesize parameters indicated by the mouclass and kbdclass event providers?
The default non-page pool allocation for keyboarddataqueuesize is **1200 bytes** and mousedataqueuesize **2400 bytes**. The value of mousedataqueuesize is the value specified in the registry multiplied by the size of the structure **MOUSE_INPUT_DATA (24 bytes)** defined in NTDDMOU.H, 100 x 24 = 2400. Similarly for the keyboarddataqueue size it is the value specified in the registry multiplied by the size of the structure **KEYBOARD_INPUT_DATA (12 bytes)** defined in NTDDKBD.H, 100 x 12 = 1200. 

<details><summary><ins>Findings and Analysis</ins></summary>

![KBDCLASS and MOUCLASS default dataqueuesize](../../DOCS/IMAGES/KBDCLASS%20and%20%20MOUCLASS%20default%20dataqueuesize.png)

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

<details><summary><ins>Findings and Analysis</ins></summary>

Using poolmon you can view the total allocated buffer space by each driver for the connected devices, in the image below there is one physical Mouse connected and one physical Keyboard using the default values. 

In this case there are two keyboard devices registered (**HID Keyboard Device** in device management), one that is part of the mouse and the keyboard itself which results in a value that is rougly 2400 bytes (1200 x 2) buffer space allocation and the remaining space likely allocated to some regular device object structure.

Then we see similar behavior for the mouse, again there is one **Mice and other pointing devices registered** (HID-compliant mouse) which results in a value that is rougly 2400 bytes (2400 x 1) and another set of bytes related to some other data structures.

![KBDCLASS and MOUCLASS non-paged pool allocation](../../DOCS/IMAGES/KBDCLASS%20and%20MOUCLASS%20non-paged%20pool%20allocation.png)

</details></br>

#### Q: Are there any paged or non-paged pool buffer allocations or frees when you move the mouse?
Yes, when you move the mouse the usb drivers hidusb.sys and usbhub3.sys dynamically allocate and free bytes associated with the amount of data processed, the more you move the mouse the more bytes seen allocated and freed. This may be different depending on the type of device and supported driver such as USB3 vs USB2. 

<details><summary><ins>Findings and Analysis</ins></summary>

Rows highlighted below represent byte allocation and frees since the last update cycle. The values displayed appear to be a total count of bytes allocated and freed perhaps since the PC was first booted as the numbers remain present after closing and re-opening poolmon.

**Screenshot of byte allocations during mouse movement via poolmon**
![HIDUSB and USBHUB3 nonpaged pool alloc mouse movement](../../DOCS/IMAGES/HIDUSB%20and%20USBHUB3%20nonpaged%20pool%20alloc%20mouse%20movement.png)

</details></br>

### Video Card
#### Q: Are there any configuration options that allow you to disable HDCP when using Nvidia based graphics cards?
As far as I'm aware there are no graphical user interface systems which allow you to do this, however you can modify the display adapters (class) HDCP configuration through the registry which allows you to define an unsupported configuration which causes the feature to be disabled. Windows or driver updates will likely revert the configuration, as will reinstalling the display adapter. To note I'm not the original pioneer of this finding, just helped to simplify it through testing.

<details><summary><ins>Findings and Analysis</ins></summary>
 
Configure the following DWORD value below for your active display adapter then resart your computer. This should cause Nvidia to display **This display does not support HDCP as configured** in the Nvidia control panel in the View HDCP Status sub-menu, third party tools can also be used to validate HDCP is disabled. 
 
The key 0002 in the registry reflects the path of the active display adapter, look for the value of **HardwareInformation.AdapterString** to help identify your display adapter and the appropriate key to create the DWORD in. (e.g. 0000, 0001, 0002)

**Example**
```
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0002]
"RMHdcpKeyglobZero"=dword:00000001
```
 
 </details></br>
 
#### Q: Is there a registry setting that can force your display adapter to remain at it's highest performance state (PState, P0)?
Yes, when the DWORD DisableDynamicPstate is set to 1 for your active graphics card under the display adapter class settings it will cause your graphics card to operate at it's highest defined frequencies similarly to setting your NVIDIA card to **Prefer Maximum Performance** in the power settings. In theory this should override NVIDIAs hidden per-application power settings (DWM, Explorer which are set to adaptive out of box).

**Disclaimer: Using this setting may cause instability in some cases.**

<details><summary><ins>Findings and Analysis</ins></summary>

While examining some of the [registry keys accessed](../FINDINGS/registrykeys_displayadapter_class_4d36e968-e325-11ce-bfc1-08002be10318.txt) during the boot process I noticed the **DisableDynamicPstate** option under the display adapter class configuration. After setting the DWORD value to 1 and restarting the computer the NVIDIA graphics card no longer changed [PState values](https://docs.nvidia.com/gameworks/content/gameworkslibrary/coresdk/nvapi/group__gpupstate.html) (it was P0) even when the NVIDIA power profiles were set to Adaptive/Optimal. This was validated using [nvidia-smi in monitoring mode](../../TROUBLESHOOTING/VIDEOCARD.md#nvidia-system-management-interface-nvidia-smi) to capture the PState and GPU core and memory frequencies during desktop use and gameplay.

**Registry Path**

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000]
"DisableDynamicPstate"=dword:00000001
```

This path won't be identical in all cases, the number 0000 references a specific video card and may be overwritten during driver installations, or if you move the GPU to another slot. To determine the appropriate reference number (eg. 0000, 0001, 0002) open registry editor and navigate to the path below then look at the "DriverDesc or HardwareInformation.AdapterString" values which should contain a name of the video card adapter e.g. **NVIDIA GeForce GTX 1050**.

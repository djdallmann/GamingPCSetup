This section contains information regarding the Windows default service configuration for systems using Windows Desktop Experience (User Interface, Taskbar and Explorer). Many of the Windows services are partially or heavily interdependant on eachother as such Microsoft does not have recommendation for changing their default configuration, however some services can be disabled if you're certain you do not use the features.

This guide will be separated into two sub-sections, Microsoft guidelines and recommendations then a section for alternative service configuration overview. Generally I recommend you start with the Microsoft recommendations then review alternative recommendations to review their purpose and potential impacts.

### Microsoft Guidelines and Recommendations
This section is based on two specific Microsoft support articles and will summarize the services which may be **disabled** and their impacts. Although the articles are specific to Windows Server with Windows Desktop Experience, the majority of recommendations will still apply.

For the Microsoft references, see the heading **Microsoft - Windows Services** in the [Technical References](../Technical%20References/README.md) page.

<details><summary><b>Click here to expand the system services summary</b></summary>
<p>

This is a list of services which Microsoft has recommendations for disabling, if a service is not on this list then Microsoft is unsure of the impacts it may have on the desktop experience.


| Service | Service Name | Impacts
| --- | --- | --- |
| AxInstSV | ActiveX Installer | Pending |
| AppReadiness | AppReadiness | Pending |
| bthserv | Bluetooth Support Service | Pending |
| bthAvctpSvc | AVCTP service | Pending |
| Browser | Computer Browser | Pending |
| dmwwappushservice | Device Management Wireless Application | Pending |
| MapsBroker | Downloaded Maps Manager | Pending |
| lfsvc | Geolocation Service | Pending |
| SharedAccess | Internet Connection Sharing | Pending |
| lltdsvc | Link-Layer Topology Discovery Mapper | Pending |
| wlidsvc | Microsoft Account Sign-in Assistant | Pending |
| AppVClient | Microsoft App-V Client | Pending |
| NgcSvc | Microsoft Passport | Pending |
| NgcCtnrSvc | Microsoft Passport Container | Pending |
| NetTcpPortSharing | Net.Tcp Port Sharing Service | Pending |
| CscService | Offline Files | Pending |
| PhoneSvc | Phone Service | Pending |
| Spooler | Print Spooler | Pending |
| PrintNotify | Printer Extensions and Notifications | Pending |
| PcaSvc | Program Compatibility Assistant Service | Pending |
| QWAVE | Quality Windows Audio Video Experience | Pending |
| RemoteAccess | Routing and Remote Access | Pending |
| SensorDataService | Sensor Data Service | Pending |
| SensrSvc | Sensor Monitoring Service | Pending |
| SensorService | Sensor Service | Pending |
| ShellHWDetection | Shell Hardware Detection | Pending |
| SCardSvr | Smart Card | Pending |
| ScDeviceEnum | Smart Card Device Enumeration Service | Pending |
| WiaRpc | Still Image Acquisition Events | Pending |
| TabletInputService | Touch Keyboard and Handwriting Panel Service | Pending |
| upnphost | UPnP Device Host | Pending |
| UevAgentService | User Experience Virtualization Service | Pending |
| WalletService | WalletService | Pending |
| Windows Camera Frame Server | FrameServer | Pending |
| stisvc | Windows Image Acquisition | Pending |
| wisvc | Windows Insider Service | Pending |
| icssvc | Windows Mobile Hotspot Service | Pending |
| WpnService | Windows Push Notifications System Service | Pending |
| WSearch | Windows Search | Pending |
| XblAuthManager | Xbox Live Auth Manager | Pending |
| XblGameSave | Xbox Live Game Save | Pending |
| SEMgrSvc | Payments and NFC/SE Manager | Pending |


</p>

</details>

<details><summary><b>Click here to expand the per-user services summary</b></summary>
<p>

This is a list of per-user services which Microsoft has recommendations for, disabling these only prevents the services from being started on login. **Per-user services are dynamically created upon creating a user session** for example you'll see ContactData service but also see the running service ContactData_37664 (per-user service), each user logged into the system will have their on per user service for those listed below if it is configured to be enabled.

| Service | Service Name | Impacts
| --- | --- | --- |
| BcastDVRUserService | GameDVR and Broadcast User Service | Pending |
| BluetoothUserService | Bluetooth User Support Service | Pending |
| PimIndexMaintenanceSvc | Contact Data | Pending |
| CaptureService | Capture Service | Pending |
| DevicePickerUserSvc | Device Picker | Pending |
| DevicesFlowUserSvc | Devices Flow | Pending |
| MessagingService | MessagingService | Pending |
| CDPUserSvc | CDPUserSvc | Pending |
| OneSyncSvc | Sync Host | Pending |
| UserDataSvc | User Data Access | Pending |
| UnistoreSvc| User Data Storage | Pending |
| WpnUserService | Windows Push Notifications User Service | Pending |
| PrintWorkflowUserSvc | PrintWorkflow | Pending |
</p>

</details>

### Alternative Service Configuration Overview
Pending

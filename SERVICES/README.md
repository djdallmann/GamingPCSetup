This section contains information regarding the Windows default service configuration for systems using Windows Desktop Experience (User Interface, Taskbar and Explorer). Many of the Windows services are partially or heavily interdependant on eachother as such Microsoft does not have recommendation for changing their default configuration, however some services can be disabled if you're certain you do not use the features.

This guide will be separated into two sub-sections, Microsoft guidelines and recommendations then a section for alternative service configuration overview. Generally I recommend you start with the Microsoft recommendations then review alternative recommendations to review their purpose and potential impacts.

### Microsoft Guidelines and Recommendations
This section is based on two specific Microsoft support articles and will summarize the services which may be **disabled** and their impacts. Although the articles are specific to Windows Server with Windows Desktop Experience, the majority of recommendations will still apply.

For the Microsoft references, see the heading **Microsoft - Windows Services** in the [Technical References](../Technical%20References/README.md) page.

<details><summary><b>Click here to expand the system services summary</b></summary>
<p>

This is a list of services which Microsoft has recommendations for disabling, if a service is not on this list then Microsoft is unsure of the impacts it may have on the desktop experience.


| Service | Service Name | Impacts | My Recommendation
| --- | --- | --- | --- |
| AxInstSV | ActiveX Installer | Provides User Account Control validation for the installation of ActiveX controls from the Internet and enables management of ActiveX control installation based on Group Policy settings | Disable
| tzautoupdate | Auto Time Zone Updater | Automatically sets the system time zone. | Keep Disabled
| bthserv | Bluetooth Support Service | The Bluetooth service supports discovery and association of remote Bluetooth devices. Stopping or disabling this service may cause already installed Bluetooth devices to fail to operate properly and prevent new devices from being discovered or associated. | Disable if you don't use or plan to use Bluetooth devices
| CDPUserSvc | Connected Devices Platform Service | If you deactivate it, the automatic mail retrieval, the update of the LiveTiles and the Infocenter should be dead. In addition, OndeDrive will no longer sync and a number of other synchronization-dependent features will cease the service. | Pending
| PimIndexMaintenanceSvc | ContactData | Indexes contact data for fast contact searching. If you stop or disable this service, contacts might be missing from your search results. | Disable completely or Per-User for shared computers, see Per-User services section.
| dmwwappushservice | Device Management Wireless Application | Service required on client devices for Intune, MDM and similar management technologies, and for Unified Write Filter. Not needed for Server. | Pending
| MapsBroker | Downloaded Maps Manager | Windows service for application access to downloaded maps. This service is started on-demand by application accessing downloaded maps. Disabling this service will prevent apps from accessing maps. | Disable if you don't use any apps that use Map based features.
| lfsvc | Geolocation Service | This service monitors the current location of the system and manages geofences (a geographical location with associated events). If you turn off this service, applications will be unable to use or receive notifications for geolocation or geofences. | Disable
| SharedAccess | Internet Connection Sharing | Provides network address translation, addressing, name resolution and/or intrusion prevention services for a home or small office network. | Disable
| lltdsvc | Link-Layer Topology Discovery Mapper | Creates a Network Map, consisting of PC and device topology (connectivity) information, and metadata describing each PC and device. If this service is disabled, the Network Map will not function properly. | Disable
| wlidsvc | Microsoft Account Sign-in Assistant | Enables user sign-in through Microsoft account identity services. If this service is stopped, users will not be able to log on to the computer with their Microsoft account. | Disable if you don't use a Microsoft account to sign-in, or for the Microsoft Store
| AppVClient | Microsoft App-V Client | Manages App-V users and virtual applications | Disable
| NgcSvc | Microsoft Passport | rovides process isolation for cryptographic keys used to authenticate to a user's associated identity providers. If this service is disabled, all uses and management of these keys will not be available, which includes machine logon and single-sign on for apps and websites. | Pending
| NgcCtnrSvc | Microsoft Passport Container | Manages local user identity keys used to authenticate user to identity providers as well as TPM virtual smart cards. If this service is disabled, local user identity keys and TPM virtual smart cards will not be accessible. | Pending
| NetTcpPortSharing | Net.Tcp Port Sharing Service | Provides ability to share TCP ports over the net.tcp protocol. | Keep Disabled
| NcbService | Network Connection Broker | Brokers connections that allow Microsoft Store Apps to receive notifications from the internet. | Disable, if you don't plan on using the MS Store apps with internet notifications
| CscService | Offline Files | The Offline Files service performs maintenance activities on the Offline Files cache, responds to user logon and logoff events | Keep Disabled
| PhoneSvc | Phone Service | Manages the telephony state on the device | Disable
| Spooler | Print Spooler | This service spools print jobs and handles interaction with the printer. If you turn off this service, you won't be able to print or see your printers. | Disable, unless you use printers or scanners
| PrintNotify | Printer Extensions and Notifications | This service opens custom printer dialog boxes and handles notifications from a remote print server or a printer. | Disable, unless you use printers or scanners
| PcaSvc | Program Compatibility Assistant Service | This service provides support for the Program Compatibility Assistant (PCA). PCA monitors programs installed and run by the user and detects known compatibility problems. | Pending
| QWAVE | Quality Windows Audio Video Experience | Quality Windows Audio Video Experience (qWave) is a networking platform for Audio Video (AV) streaming applications on IP home networks. | Disable
| RmSvc | Radio Management Service | Radio Management and Airplane Mode Service | Disable, if you don't use or plan to use wifi etc
| RemoteAccess | Routing and Remote Access | Offers routing services to businesses in local area and wide area network environments. | Disable
| SensorDataService | Sensor Data Service | Delivers data from a variety of sensors | Disable
| SensrSvc | Sensor Monitoring Service | Monitors various sensors in order to expose data and adapt to system and user state. If this service is stopped or disabled, the display brightness will not adapt to lighting conditions. | Disable
| SensorService | Sensor Service | A service for sensors that manages different sensors' functionality. | Disable
| ShellHWDetection | Shell Hardware Detection | Provides notifications for AutoPlay hardware events. | Disable
| SCardSvr | Smart Card | Manages access to smart cards read by this computer. | Disable if you don't use smart cards
| ScDeviceEnum | Smart Card Device Enumeration Service | Creates software device nodes for all smart card readers accessible to a given session. | Disable if you don't use smart cards
| SSDPSRV | SSDP Discovery | Discovers networked devices and services that use the SSDP discovery protocol, such as UPnP devices. | Disable
| WiaRpc | Still Image Acquisition Events | Launches applications associated with still image acquisition events. | Disable if you don't use a scanner.
| OneSyncSvc | Sync Host | This service synchronizes mail, contacts, calendar and various other user data. | Disable completely or Per-User for shared computers, see Per-User services section.
| TabletInputService | Touch Keyboard and Handwriting Panel Service | Enables Touch Keyboard and Handwriting Panel pen and ink functionality | Disable if you don't use these features.
| upnphost | UPnP Device Host | Allows UPnP devices to be hosted on this computer. If this service is stopped, any hosted UPnP devices will stop functioning and no additional hosted devices can be added. | Disable
| UserDataSvc | User Data Access | Provides apps access to structured user data, including contact info, calendars, messages, and other content. | Disable if you don't use these built-in features
| UevAgentService | User Experience Virtualization Service | Provides support for application and OS settings roaming | Keep disabled
| WalletService | WalletService | Hosts objects used by clients of the wallet | Disable
| Windows Camera Frame Server | FrameServer | Enables multiple clients to access video frames from camera devices. | Disable
| stisvc | Windows Image Acquisition | Provides image acquisition services for scanners and cameras | Disable if you don't use image scanners
| wisvc | Windows Insider Service | Windows Insider Service | Disable if you don't subscribe to insider services
| icssvc | Windows Mobile Hotspot Service | Provides the ability to share a cellular data connection with another device. | Disable
| WpnService | Windows Push Notifications System Service | This service runs in session 0 and hosts the notification platform and connection provider which handles the connection between the device and WNS server. | Pending
| WpnUserService | Windows Push Notifications User Service | This service hosts Windows notification platform which provides support for local and push notifications. Supported notifications are tile, toast and raw. | Disabling this doesn't prevent per-user service from running, see per-user section for this one.
| WSearch | Windows Search | Provides content indexing, property caching, and search results for files, e-mail, and other content. | Disable
| XblAuthManager | Xbox Live Auth Manager | Provides authentication and authorization services for interacting with Xbox Live. If this service is stopped, some applications may not operate correctly. | Disable if you don't use XBox Live Features
| XblGameSave | Xbox Live Game Save | This service syncs save data for Xbox Live save enabled games. If this service is stopped, game save data will not upload to or download from Xbox Live. | Disable if you don't use XBox Live Features

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

<details><summary><b>Click here to expand the alternative services summary</b></summary>
<p>

| Service | Service Name | Impacts | My Recommendation
| --- | --- | --- | --- |
| SEMgrSvc | Payments and NFC/SE Manager | Near field communications for payments, tap to pay | Disable
  
</p>
</details>

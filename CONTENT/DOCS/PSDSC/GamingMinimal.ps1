# This SOFTWARE PRODUCT is provided by THE PROVIDER "as is" and "with all faults." 
# THE PROVIDER makes no representations or warranties of any kind concerning the safety, 
# suitability, inaccuracies, typographical errors, or other harmful components 
# of this SOFTWARE PRODUCT. There are inherent dangers in the use of any software, and you are 
# solely responsible for determining whether this SOFTWARE PRODUCT is compatible with your equipment 
# and other software installed on your equipment. You are also solely responsible for the protection 
# of your equipment and backup of your data, and THE PROVIDER will not be liable for any damages you 
# may suffer in connection with using, modifying, or distributing this SOFTWARE PRODUCT.
#
#
# Author: DDallmann (Alias Timecard, TC!)
# https://github.com/djdallmann
# https://play.esea.net/users/26101
# steamcommunity.com/id/tcard
param([Parameter(Mandatory=$true)] [String]$myusername)
Configuration GamingMinimal {
    # Import the module that contains the resources we're using.
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    $mysid = (New-Object System.Security.Principal.NTAccount($myusername)).Translate([System.Security.Principal.SecurityIdentifier]).value

    # The Node statement specifies which targets this configuration will be applied to.
    Node "localhost" {

        ###########################
        # USER SETTINGS/PREFERENCES
        ###########################
        # Privacy Settings
        # https://privacyamp.com/knowledge-base/windows-10-privacy-settings/
        Registry ShowAllIconsTaskbar {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
            ValueName   = "EnableAutoTray"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry VisualEffects {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
            ValueName   = "VisualFXSetting"
            ValueData   = "2"
            ValueType = "Dword"
        }
        #Disable Enhanced Pointer Precision set 6/11
        Registry MouseSpeed {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Mouse"
            ValueName   = "MouseSpeed"
            ValueData   = "0"
            ValueType = "String"
        }
        Registry MouseThreshold1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Mouse"
            ValueName   = "MouseThreshold1"
            ValueData   = "0"
            ValueType = "String"
        }
        Registry MouseThreshold2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Mouse"
            ValueName   = "MouseThreshold2"
            ValueData   = "0"
            ValueType = "String"
        }
        Registry MouseSensitivity {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Mouse"
            ValueName   = "MouseSensitivity"
            ValueData   = "10"
            ValueType = "String"
        }
        Registry DisableScrollInactiveWindow {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Desktop"
            ValueName   = "MouseWheelRouting"
            ValueData   = "0"
            ValueType = "Dword"
        }
        #Disable Touch Feedback
        Registry DisableMouseTouchFeedback1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Cursors"
            ValueName   = "ContactVisualization"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableMouseTouchFeedback2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Cursors"
            ValueName   = "GestureVisualization"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableOnlineSpeechPrivacyandRecognition {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy"
            ValueName   = "HasAccepted"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableCortanaTaskbar {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
            ValueName   = "CortanaEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableCortanaBingWebSearch {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
            ValueName   = "BingSearchEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DoNotGiveCortanaConsent {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
            ValueName   = "CortanaConsent"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableAdvertisingInfo {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
            ValueName   = "Enabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableInfoByLanguageList {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\International\User Profile"
            ValueName   = "HttpAcceptLanguageOptOut"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableAppLaunchTracking {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
            ValueName   = "Start_TrackProgs"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableSuggestedContent1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
            ValueName   = "SubscribedContent-338393Enabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableSuggestedContent2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
            ValueName   = "SubscribedContent-338394Enabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableSuggestedContent3 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
            ValueName   = "SubscribedContent-338396Enabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableInkingandPersonalization1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Personalization\Settings"
            ValueName   = "AcceptedPrivacyPolicy"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableInkingandPersonalization2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language"
            ValueName   = "Enabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableInkingandPersonalization3 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\InputPersonalization"
            ValueName   = "RestrictImplicitTextCollection"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableInkingandPersonalization4 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\InputPersonalization"
            ValueName   = "RestrictImplicitInkCollection"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableInkingandPersonalization5 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\InputPersonalization\TrainedDataStore"
            ValueName   = "HarvestContacts"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DiagnosticsBasicUser1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack"
            ValueName   = "ShowedToastAtLevel"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableTailoredExperiences {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Privacy"
            ValueName   = "TailoredExperiencesWithDiagnosticDataEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableFeedbackFrequency {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Siuf\Rules"
            ValueName   = "NumberOfSIUFInPeriod"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableAppsUsingCamera {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppBluetoothAccess {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableCommUnpairedDevices {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableBackgroundApps1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Search"
            ValueName   = "BackgroundAppGlobalToggle"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableBackgroundApps2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
            ValueName   = "GlobalUserDisabled"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry ShowFileExtensions {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
            ValueName   = "HideFileExt"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableNarrator1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows NT\CurrentVersion\AccessibilityTemp"
            ValueName   = "narrator"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableNarrator2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Narrator\NoRoam"
            ValueName   = "RunningState"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableAutoCorrect {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\TabletTip\1.7"
            ValueName   = "EnableAutocorrection"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableSpellChecking {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\TabletTip\1.7"
            ValueName   = "EnableSpellchecking"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableTypePrediction {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\TabletTip\1.7"
            ValueName   = "EnableTextPrediction"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableSpaceInsertPrediction {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\TabletTip\1.7"
            ValueName   = "EnablePredictionSpaceInsertion"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableDoubleTapSpace {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\TabletTip\1.7"
            ValueName   = "EnableDoubleTapSpace"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableTypingInsights1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Input\Settings"
            ValueName   = "InsightsEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableTypingInsights2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Input\Settings"
            ValueName   = "Insights"
            ValueData   = "01000000071de8c131cc8360a3d6d9c1330a686b165aba2e235f5a5c"
            ValueType = "Binary"
        }
        Registry DisableSwiftKeySuggestionsLangEnglishUS {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\TabletTip\1.7"
            ValueName   = "EnableInkingWithTouch"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisablePenandInk {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\PenWorkspace"
            ValueName   = "PenWorkspaceAppSuggestionsEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableAutoPlay {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers"
            ValueName   = "DisableAutoplay"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableGameBar {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\System\GameConfigStore"
            ValueName   = "GameDVR_Enabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableGameBarControllerShortcut {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\GameBar"
            ValueName   = "UseNexusForGameBarEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableGamingAudioCaptures {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\GameDVR"
            ValueName   = "AudioCaptureEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableGamingHistoricalCaptures {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\GameDVR"
            ValueName   = "HistoricalCaptureEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableGamingCursorCaptures {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\GameDVR"
            ValueName   = "CursorCaptureEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableGamingBroadcasting1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings"
            ValueName   = "AudioCaptureEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableGamingBroadcasting2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings"
            ValueName   = "MicrophoneCaptureEnabledByDefault"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableGamingBroadcasting3 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings"
            ValueName   = "CursorCaptureEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableGamingBroadcasting4 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\AppBroadcast\GlobalSettings"
            ValueName   = "CameraCaptureEnabledByDefault"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableGamingMode {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\GameBar"
            ValueName   = "AutoGameModeEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableSigninOptionReopenApps {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserARSO\${mysid}"
            ValueName   = "OptOut"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableLoginBackgroundImageonLockScreen {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SystemProtectedUserData\${mysid}\AnyoneRead\LockScreen\"
            ValueName   = "HideLogonBackgroundImage"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableOneDriveStartUp {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run"
            ValueName   = "OneDrive"
            ValueData   = "0100000004077640378fd401"
            ValueType = "Binary"
        }
        Registry DisablePersonalizationTransparencyEffect {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
            ValueName   = "EnableTransparency"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableShowPeopleOnTaskbar {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"
            ValueName   = "PeopleBand"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableAutoDetectProxy {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
            ValueName   = "ProxyEnable"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableShareAcrossDevices1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\CDP"
            ValueName   = "RomeSdkChannelUserAuthzPolicy"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableShareAcrossDevices2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\CDP"
            ValueName   = "CdpSessionUserAuthzPolicy"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableLockScreenNotifications1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\PushNotifications"
            ValueName   = "LockScreenToastEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableLockScreenNotifications2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings"
            ValueName   = "NOC_GLOBAL_SETTING_ALLOW_TOASTS_ABOVE_LOCK"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableLockScreenNotifications3 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings"
            ValueName   = "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableToastNotifications {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\PushNotifications"
            ValueName   = "ToastEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry EnforceDesktopModeNotTablet1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell"
            ValueName   = "SignInMode"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry EnforceDesktopModeNotTablet2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell"
            ValueName   = "ConvertibleSlateModePromptPreference"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableMultitaskingSnap {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Desktop"
            ValueName   = "WindowArrangementActive"
            ValueData   = "0"
            ValueType = "String"
        }

        ##########################
        # SYSTEM/MACHINE SETTINGS
        ###########################
        # Disable Services
        # https://docs.microsoft.com/en-us/windows-server/security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server
        # Privacy Settings
        # https://privacyamp.com/knowledge-base/windows-10-privacy-settings/
        if (Get-Service "AxInstSV" -ErrorAction SilentlyContinue ) {
            Service SvcAxInstSV {
                Name   = "AxInstSV"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "tzautoupdate" -ErrorAction SilentlyContinue ) {
            Service Svctzautoupdate {
                Name   = "tzautoupdate"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "bthserv" -ErrorAction SilentlyContinue ) {
            Service Svcbthserv {
                Name   = "bthserv"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "dmwappushservice" -ErrorAction SilentlyContinue ) {
            Service Svcdmwappushservice {
                Name   = "dmwappushservice"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "MapsBroker" -ErrorAction SilentlyContinue ) {
            Service SvcMapsBroker {
                Name   = "MapsBroker"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "lfsvc" -ErrorAction SilentlyContinue ) {
            Service Svclfsvc {
                Name   = "lfsvc"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "SharedAccess" -ErrorAction SilentlyContinue ) {
            Service SvcSharedAccess {
                Name   = "SharedAccess"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "lltdsvc" -ErrorAction SilentlyContinue ) {
            Service Svclltdsvc {
                Name   = "lltdsvc"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "AppVClient" -ErrorAction SilentlyContinue ) {
            Service SvcAppVClient {
                Name   = "AppVClient"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "NetTcpPortSharing" -ErrorAction SilentlyContinue ) {
            Service SvcNetTcpPortSharing {
                Name   = "NetTcpPortSharing"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "CscService" -ErrorAction SilentlyContinue ) {
            Service SvcCscService {
                Name   = "CscService"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "PhoneSvc" -ErrorAction SilentlyContinue ) {
            Service SvcPhoneSvc {
                Name   = "PhoneSvc"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "Spooler" -ErrorAction SilentlyContinue ) {
            Service SvcSpooler {
                Name   = "Spooler"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "PrintNotify" -ErrorAction SilentlyContinue ) {
            Service SvcPrintNotify {
                Name   = "PrintNotify"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "QWAVE" -ErrorAction SilentlyContinue ) {
            Service SvcQWAVE {
                Name   = "QWAVE"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "RmSvc" -ErrorAction SilentlyContinue ) {
            Service SvcRmSvc {
                Name   = "RmSvc"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "RemoteAccess" -ErrorAction SilentlyContinue ) {
            Service SvcRemoteAccess {
                Name   = "RemoteAccess"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "SensorDataService" -ErrorAction SilentlyContinue ) {
            Service SvcSensorDataService {
                Name   = "SensorDataService"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "SensrSvc" -ErrorAction SilentlyContinue ) {
            Service SvcSensrSvc {
                Name   = "SensrSvc"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "SensorService" -ErrorAction SilentlyContinue ) {
            Service SvcSensorService {
                Name   = "SensorService"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "ShellHWDetection" -ErrorAction SilentlyContinue ) {
            Service SvcShellHWDetection {
                Name   = "ShellHWDetection"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "SCardSvr" -ErrorAction SilentlyContinue ) {
            Service SvcSCardSvr {
                Name   = "SCardSvr"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "ScDeviceEnum" -ErrorAction SilentlyContinue ) {
            Service SvcScDeviceEnum {
                Name   = "ScDeviceEnum"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "SSDPSRV" -ErrorAction SilentlyContinue ) {
            Service SvcSSDPSRV {
                Name   = "SSDPSRV"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "WiaRpc" -ErrorAction SilentlyContinue ) {
            Service SvcWiaRpc {
                Name   = "WiaRpc"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "TabletInputService" -ErrorAction SilentlyContinue ) {
            Service SvcTabletInputService {
                Name   = "TabletInputService"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "upnphost" -ErrorAction SilentlyContinue ) {
            Service Svcupnphost {
                Name   = "upnphost"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "UevAgentService" -ErrorAction SilentlyContinue ) {
            Service SvcUevAgentService {
                Name   = "UevAgentService"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "WalletService" -ErrorAction SilentlyContinue ) {
            Service SvcWalletService {
                Name   = "WalletService"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "FrameServer" -ErrorAction SilentlyContinue ) {
            Service SvcFrameServer {
                Name   = "FrameServer"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "stisvc" -ErrorAction SilentlyContinue ) {
            Service Svcstisvc {
                Name   = "stisvc"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "wisvc" -ErrorAction SilentlyContinue ) {
            Service Svcwisvc {
                Name   = "wisvc"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "icssvc" -ErrorAction SilentlyContinue ) {
            Service Svcicssvc {
                Name   = "icssvc"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "WSearch" -ErrorAction SilentlyContinue ) {
            Service SvcWSearch {
                Name   = "WSearch"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "XblAuthManager" -ErrorAction SilentlyContinue ) {
            Service SvcXblAuthManager {
                Name   = "XblAuthManager"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "XblGameSave" -ErrorAction SilentlyContinue ) {
            Service SvcXblGameSave {
                Name   = "XblGameSave"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "SEMgrSvc" -ErrorAction SilentlyContinue ) {
            Service SvcSEMgrSvc {
                Name   = "SEMgrSvc"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "DiagTrack" -ErrorAction SilentlyContinue ) {
            Service SvcDiagTrack {
                Name   = "DiagTrack"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "NcdAutoSetup" -ErrorAction SilentlyContinue ) {
            Service SvcNcdAutoSetup {
                Name   = "NcdAutoSetup"
                State = "Stopped"
                StartupType = "Disabled"
            }
        }
        if (Get-Service "WinRM" -ErrorAction SilentlyContinue ) {
            Service SvcWindowsRemoteManagement {
                Name   = "WinRM"
                State = "Running"
                StartupType = "Automatic"
            }
        }
        Registry DisableMulticastDNS {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient"
            ValueName   = "EnableMulticast"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableLockScreenApp {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization"
            ValueName   = "NoLockScreen"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisablePowerThrottleFeature {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling"
            ValueName   = "PowerThrottlingOff"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableAutomaticDeviceMetaDataDownload {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata"
            ValueName   = "PreventDeviceMetadataFromNetwork"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableAutomaticUpdates {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
            ValueName   = "NoAutoUpdate"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableStoreAutomaticUpdates {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore"
            ValueName   = "AutoDownload"
            ValueData   = "2"
            ValueType = "Dword"
        }
        Registry DisableCortanaSearch {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
            ValueName   = "AllowCortana"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableCortanaWebSearch {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
            ValueName   = "DisableWebSearch"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DiagnosticsBasic1 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
            ValueName   = "AllowTelemetry"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DiagnosticsBasic2 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
            ValueName   = "MaxTelemetryAllowed"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DiagnosticsBasic3 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack"
            ValueName   = "UploadPermissionReceived"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DiagnosticsBasic4 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack"
            ValueName   = "DiagTrackAuthorization"
            ValueData   = "775"
            ValueType = "Dword"
        }
        Registry DiagnosticsBasic5 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack"
            ValueName   = "DiagTrackStatus"
            ValueData   = "2"
            ValueType = "Dword"
        }
        Registry DiagnosticsBasic6 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\TraceManager"
            ValueName   = "miniTraceSlotEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DiagnosticsBasic7 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\TraceManager"
            ValueName   = "miniTraceSlotContentPermitted"
            ValueData   = "1"
            ValueType = "Dword"
        }
        Registry DisableActivityPublishing {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System"
            ValueName   = "PublishUserActivities"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableActivityUpload {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System"
            ValueName   = "UploadUserActivities"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableAppNotificationsAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppAccountInfoAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppContactInfoAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppPhoneCall {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppCalendarAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppCallHist {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppEmailsAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppTaskAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppMessagingAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppRadioAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppDiagAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppDocumentAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppPicutresAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppVideoAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableAppFileSystemAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
        }
        Registry DisableDeliveryOptDownloadOtherPCs1 {
            Ensure = "Present"
            Key = "HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings"
            ValueName   = "DownloadMode"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableDeliveryOptDownloadOtherPCs2 {
            Ensure = "Present"
            Key = "HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings"
            ValueName   = "DownloadModeProvider"
            ValueData   = "8"
            ValueType = "Dword"
        }
        Registry DisableFindMyDevice {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Settings\FindMyDevice"
            ValueName   = "LocationSyncEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry PreferIPv4overIPv6 {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
            ValueName   = "DisabledComponents"
            ValueData   = "32"
            ValueType = "Dword"
        }
        Registry DisableRemoteAssistance {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Remote Assistance"
            ValueName   = "fAllowToGetHelp"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableCloudSearch {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
            ValueName   = "AllowCloudSearch"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableFastBoot {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Power"
            ValueName   = "HiberbootEnabled"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableShowSleep {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings"
            ValueName   = "ShowSleepOption"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableShowHibernate {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings"
            ValueName   = "ShowHibernateOption"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry EnableHighPerfPowerScheme {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Power\User\PowerSchemes"
            ValueName   = "ActivePowerScheme"
            ValueData   = "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
            ValueType = "String"
        }
        Registry DisableUSBSelectiveSuspend {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Power\User\PowerSchemes\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c\2a737441-1930-4402-8d77-b2bebba308a3\48e6b7a6-50f5-4782-a5d4-53bb8f07e226"
            ValueName   = "ACSettingIndex"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableDefenderAutomaticSampleSubmit {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet"
            ValueName   = "SubmitSamplesConsent"
            ValueData   = "0"
            ValueType = "Dword"
        }
        Registry DisableGameDVR {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
            ValueName   = "AllowgameDVR"
            ValueData   = "0"
            ValueType = "Dword"
        }
        #WindowsOptionalFeature PrinttoPDF {
        #    Name = "Printing-PrintToPDFServices-Features"
        #    Ensure = "Disable"
        #}
        #WindowsOptionalFeature WorkFolders {
        #    Name = "WorkFolders-Client"
        #    Ensure = "Disable"
        #}
        #WindowsOptionalFeature XPS {
        #    Name = "Printing-XPSServices-Features"
        #    Ensure = "Disable"
        #}
        #WindowsOptionalFeature PrintFeatures {
        #    Name = "Printing-Foundation-Features"
        #    Ensure = "Disable"
        #}
        #WindowsOptionalFeature WindowsMediaPlayer {
        #    Name = "WindowsMediaPlayer"
        #    Ensure = "Disable"
        #}
        #WindowsOptionalFeature InternetExplorer {
        #    Name = "Internet-Explorer-Optional-amd64"
        #    Ensure = "Disable"
        #}

    }
}
GamingMinimal

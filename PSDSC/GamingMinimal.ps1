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

Configuration GamingMinimal {

    # Import the module that contains the resources we're using.
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    $myusername = "ddallmann"
    $mysid = (New-Object System.Security.Principal.NTAccount($myusername)).Translate([System.Security.Principal.SecurityIdentifier]).value

    # The Node statement specifies which targets this configuration will be applied to.
    Node 'localhost' {

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
        #Disable Sticky Keys Shortcut
        Registry DisableStickyKeysShort {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Accessibility\StickyKeys"
            ValueName   = "Flags"
            ValueData   = "506"
            ValueType = "String"
        }
        #Disable Toggle Keys Shortcut
        Registry DisableToggleKeysShort {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Accessibility\ToggleKeys"
            ValueName   = "Flags"
            ValueData   = "58"
            ValueType = "String"
        }
        #Disable Filter Keys Shortcut
        Registry DisableFilterKeys1 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Accessibility\Keyboard Response"
            ValueName   = "Flags"
            ValueData   = "122"
            ValueType = "String"
        }
        Registry DisableFilterKeys2 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Accessibility\Keyboard Response"
            ValueName   = "DelayBeforeAcceptance"
            ValueData   = "0"
            ValueType = "String"
        }
        Registry DisableFilterKeys3 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Accessibility\Keyboard Response"
            ValueName   = "AutoRepeatDelay"
            ValueData   = "0"
            ValueType = "String"
        }
        Registry DisableFilterKeys4 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Accessibility\Keyboard Response"
            ValueName   = "AutoRepeatRate"
            ValueData   = "0"
            ValueType = "String"
        }
        Registry DisableFilterKeys5 {
            Ensure = "Present"
            Key = "HKEY_USERS\${mysid}\Control Panel\Accessibility\Keyboard Response"
            ValueName   = "BounceTime"
            ValueData   = "0"
            ValueType = "String"
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

        ###########################
        # SYSTEM/MACHINE SETTINGS
        ###########################
        # Disable Services
        # https://docs.microsoft.com/en-us/windows-server/security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server
        # Privacy Settings
        # https://privacyamp.com/knowledge-base/windows-10-privacy-settings/
        Service SvcAllJoyn {
            Name   = "AJRouter"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcAppLayerGateway {
            Name   = "ALG"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcAppMgmtGrpPolicy {
            Name   = "AppMgmt"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcBluetoothAudioGateway {
            Name   = "BTAGService"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcBluetoothSupportService {
            Name   = "bthserv"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcBranchCache {
            Name   = "PeerDistSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcCertPropagation {
            Name   = "CertPropSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcDiagTrack {
            Name   = "DiagTrack"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcDownloadedMapsMgr {
            Name   = "MapsBroker"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcGeoLocation {
            Name   = "lfsvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcHVHost {
            Name   = "HvHost"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcHVDataExch {
            Name   = "vmickvpexchange"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcHVGuestInterface {
            Name   = "vmicguestinterface"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcHVGuestShutdown {
            Name   = "vmicshutdown"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcHVHeartBeat {
            Name   = "vmicheartbeat"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcHVPowershell {
            Name   = "vmicvmsession"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcHVRDP {
            Name   = "vmicrdv"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcHVTime {
            Name   = "vmictimesync"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcHVVolumeShadow {
            Name   = "vmicvss"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcInfrared {
            Name   = "irmon"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcInternetConnSharing {
            Name   = "SharedAccess"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcIPHelperipv6 {
            Name   = "iphlpsvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcIPTranslateipv6 {
            Name   = "IpxlatCfgSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcMsAccountSignIn {
            Name   = "wlidsvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcAppvclient {
            Name   = "AppVClient"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcSMSRouter {
            Name   = "SmsRouter"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcNaturalAuth {
            Name   = "NaturalAuthentication"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcNetlogon {
            Name   = "Netlogon"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcNetDvcAutoSetup {
            Name   = "NcdAutoSetup"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcParentalControls {
            Name   = "WpcMonSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcNFC {
            Name   = "SEMgrSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcPhoneService {
            Name   = "PhoneSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcPrintSpooler {
            Name   = "Spooler"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcProgramCompat {
            Name   = "PcaSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcRPCLocator {
            Name   = "RpcLocator"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcRemoteRegistry {
            Name   = "RemoteRegistry"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcRetailDemo {
            Name   = "RetailDemo"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcSensorDataService {
            Name   = "SensorDataService"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcSensorMon {
            Name   = "SensrSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcSensorServ {
            Name   = "SensorService"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcSmartCard {
            Name   = "SCardSvr"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcSmartCardDevEnum {
            Name   = "ScDeviceEnum"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcSmartCardRemove {
            Name   = "SCPolicySvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcSnmptrap {
            Name   = "SNMPTRAP"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcSSDP {
            Name   = "SSDPSRV"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWebClient {
            Name   = "WebClient"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWifiDirect {
            Name   = "WFDSConMgrSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWinCameraFrameServ {
            Name   = "FrameServer"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWinConnectNow {
            Name   = "wcncsvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWinImageAcquisition {
            Name   = "stisvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcMobileHotspot {
            Name   = "icssvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWinPerception {
            Name   = "spectrum"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWinPerceptionSim {
            Name   = "perceptionsimulation"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWinPush {
            Name   = "WpnService"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWlanautoconfig {
            Name   = "WlanSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWWANAuto {
            Name   = "WwanSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcXboxAccessory {
            Name   = "XboxGipSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcXboxliveauth {
            Name   = "XblAuthManager"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcXboxgamesave {
            Name   = "XblGameSave"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcXboxnetwork {
            Name   = "XboxNetApiSvc"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        #FileSharing/Comms
        Service SvcWorkstation {
            Name   = "LanmanWorkstation"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcServer {
            Name   = "LanmanServer"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcNetBios {
            Name   = "lmhosts"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcTouchKeyboardandHandwriting {
            Name   = "TabletInputService"
            State = 'Stopped'
            StartupType = 'Disabled'
        }
        Service SvcWindowsRemoteManagement {
            Name   = "WinRM"
            State = 'Running'
            StartupType = 'Automatic'
        }
        Registry DisableCortanaSearch {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
            ValueName   = "AllowCortana"
            ValueData   = "0"
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
        Registry DisableAppMicroPhoneAccess {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone"
            ValueName   = "Value"
            ValueData   = "Deny"
            ValueType = "String"
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
            ValueData   = "Allow"
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

## Audio Configuration
This section provides recommendations for your audio configuration, it also covers a few bugs, known issues which may impact your experience.

### Microsoft Windows
* Microsoft has released several updates which impacted clarity and volume of audio for example being dampened or muffled.
  * [Microsoft KB4515384](https://support.microsoft.com/en-us/help/4515384/windows-10-update-kb4515384)
    * Microsoft has received reports that audio in certain games is quieter or different than expected after installing this update. At the request of some of our audio partners, we implemented a compatibility change that enabled certain games to query support and render multi-channel audio. Due to customer feedback, we are reverting this change as some games and some devices are not rendering multi-channel audio as expected. This may result in games sounding different than customers are used to and may have missing channels.
    * Resolution see [Microsoft KB4517211](https://support.microsoft.com/en-us/help/4517211/windows-10-update-kb4517211)

#### Recommendation    
1. Disabled Audio/Signal Enhancements
2. Enable Exclusive Mode
3. Increase Windows volume (Speakers and System Sounds) to 100% and decrease volume ingame or applications
4. Disable the Sound Communications Option which automatically reduces sound in some circumstances.
   * Control Panel > Hardware and Sound > Sound > Communications > **Set to Do Nothing**
5. Set Output to Headphones instead of Speakers (may require driver)

### REALTEK HD Audio
#### Recommendation
1. Download and install the latest REALTEK HD AUDIO driver
   * [Download REALTEK HD Audio Driver](https://downloadcenter.intel.com/download/28433/Realtek-High-Definition-Audio-Driver-for-Windows-10-64-bit-for-NUC8i7BE-NUC8i5BE-NUC8i3BE)
   * Note: If the software ends up in a loop of trying to uninstall the old driver, uninstall the driver first from Device Manager then launch the Setup application.
2. Open the **REALTEK Audio Console**, go to **Device Advanced Settings** and ensure your audio input (**front or backpanel**) is set to **Headphones** instead of speakers.
   * **Note: This will change everytime you unplug your headset, so you need to do it each time**

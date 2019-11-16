## Install and Setup Steam
1. Go to https://www.steampowered.com/ and press **Install Steam** in the upper right hand corner of your screen, choose save or run
2. Run the installer and complete the basic installation
3. Login to Steam
4. Open Windows 10 Task Manager disable Steam from automatic Startup.
5. Open steam settings
   - Go to **In-Game** and uncheck the following:
     - Enable the steam overlay while in-game
     - Use the Big Picture ...
     - Use Desktop Game Theatre ...
   - Go to **In-home Streaming** and uncheck Enable Streaming
   - Go to **Cloud** and uncheck all options, this will eliminate any old configs getting loaded from the cloud should they be interfering.
   - Go to **Broadcasting** and disable broadcasting
   - Go to **Shader Pre-Caching** and disable the feature
   - Go to **Library** and enable any or all of the settings to reduce steam graphical and network overhead
     - Low Bandwidth Mode
     - Disable Community Content
     - Low Performance Mode (this also turns on Disable Community Content)
6. Press OK to save all your changes.
7. Install your games
8. **For each game** right click and go to properties, on the General tab choose **Forced-off** for **Steam Input Per-Game Setting**
8. Close Steam fully by right clicking the icon in your taskbar and choosing Exit
9. Right-click the icon on your desktop and add the following option ```"C:\Program Files (x86)\Steam\Steam.exe" -no-browser```
   - https://developer.valvesoftware.com/wiki/Command_Line_Options#Steam_.28Windows.29
   - This will prevent steam chrome based steamwebhelper.exe processes from spawning but will also disable the new Friends UI and some web services. These have been known to cause interference.
10. Going forward you will manually launch Steam from your desktop shortcut which has the customized launch option.

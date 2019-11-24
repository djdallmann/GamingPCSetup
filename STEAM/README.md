## Install and Setup Steam
1. Go to https://www.steampowered.com/ and press **Install Steam** in the upper right hand corner of your screen, choose save or run
2. Run the installer and complete the basic installation
3. Login to Steam
4. Open steam settings
   - Go to **In-Game** and uncheck the following:
     - Enable the steam overlay while in-game
     - Use the Big Picture ...
     - Use Desktop Game Theatre ...
   - Go to **In-home Streaming** and uncheck Enable Streaming
   - Go to **Remote Play** and uncheck Enable Remote Play
   - Go to **Cloud** and uncheck all options, this will eliminate any old configs getting loaded from the cloud should they be interfering.
   - Go to **Broadcasting** and disable broadcasting
   - Go to **Library** and enable any or all of the settings to reduce steam graphical and network overhead
     - Low Bandwidth Mode
     - Disable Community Content
     - Low Performance Mode (this also turns on Disable Community Content)
5. Press OK to save all your changes.
6. Install your games
7. Restart Steam by right clicking the icon in your taskbar and choose Exit, then re-open Steam.
8. If you want to run Steam without the web services and a limited friends interface follow the next two steps.
   - Right-click the icon on your desktop and add the following option ```"C:\Program Files (x86)\Steam\Steam.exe" -no-browser```
      - https://developer.valvesoftware.com/wiki/Command_Line_Options#Steam_.28Windows.29
      - This will prevent steam chrome based steamwebhelper.exe processes from spawning but will also disable the new Friends UI and some web services. These have been known to cause interference in some games.
   - Going forward you will manually launch Steam from your desktop shortcut which has the customized launch option.

## Steam Game Launch Options
The following is a list of notable launch options:
   - **-freq or -refresh** `<monitor refresh rate>`
      - e.g. -freq 144
      - This sets the monitors refresh rate when the game is launched, set this to a higher value if your monitor supports it (100hz, 120hz, 144hz). **-refresh does the same thing**
   - **-novid**
      - This setting disables the intro video after launching CSGO.
   - **-console**
      - Automatically opens the games console after launching the game, useful if you want to check your settings or make some changes before you play.
   - **-tickrate**
      - This determines sets the game tick interval essentially determining the frequency the game processes information, higher the better. This affects your experience when playing against bots or other local listen server modes. (Default: 64)
   - **-high**
      - This forces the CSGO process priority to high. Changing this may or may not have a positive impact on your experience. 
   - **-threads #**
      - e.g. -threads 4
      - Determines the amount of threads to allocate to the game, this is set to 3 by default. If you have a large number of cores (+6) you could try increasing it to a value above the default. Changing this may or may not have a positive impact on your experience. 
      
**NOTE: Valve has publicly stated they typically test their game without any launch options, as such is is recommended to keep them to the minimum.**
      
### Common Launch Option Settings:
   - `-novid -tickrate 128 -freq <refreshrate>`
   - `-novid -tickrate 128 -console -freq <refreshrate>`
   - `-novid -freq <refreshrate>`
   - `-novid -console -freq <refreshrate>`
   
### Launch Option References:
   - A complete list of command line options for the Source Engine (HL2)
      - https://developer.valvesoftware.com/wiki/Command_Line_Options#Source_Games

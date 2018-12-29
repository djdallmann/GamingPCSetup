## Steam Game Launch Options
The following is a list of notable launch options:
   - **-noforcemparms**
      - Uses the mouse configuration settings defined in Windows Control Panel Mouse settings, use all windows mouse settings/thresholds. **This should technically be the same as when all three are combined (-noforcemparms -noforcemspd -noforcemaccel), see github code reference below**
   - **-noforcemspd**
      - Uses windows defined mouse **Enhanced Pointer Precision** settings, if disabled in windows will be disabled in-game with this option
   - **-noforcemaccel**
      - Uses windows **mouse threshold settings** for acceleration, determines how acceleration is multiplied
   - **-nomsaa**
      - Disables in-game post processing anti-aliasing, **this is automatically implied when -nofbo is used.**
   - **-stretchaspect**
      - The game by default adds black bars based on your game screen resolution. Use -stretchaspect on your command line if you want the old behavior back (just always fill the screen). **Setting "-nofbo" also implies "-stretchaspect".**
   - **-freq** `<monitor refresh rate>`
      - e.g. -freq 144
      - This sets the monitors refresh rate when the game is launched, set this to a higher value if your monitor supports it (100hz, 120hz, 144hz)
      - This setting works with the new rendering mode (when you **do not** have -nofbo specified)
      - In order to get the proper **monitor refresh rate with -nofbo** enabled you must set your desktop refreshrate to the desired refreshrate first, assuming the in-game resolution supports the refresh rate.
   - **-nofbo**
      - Uses the rendering method similar to the one before the 2013 updates, this may improve performance on some PCs. See note above regarding nofbo and in-game monitor refresh rate. **This also implies the use of -nomsaa**
      
### Common Launch Option Settings:
**With Old Rendering Method (nofbo)**
   - `-noforcemparms -noforcemspd -noforcemaccel -nofbo -freq <refreshrate>`
   - `-noforcemparms -noforcemaccel -nofbo -freq <refreshrate>`
   - `-noforcemparms -nofbo -freq <refreshrate>`

**With New Rendering Method**
   - `-noforcemparms -noforcemspd -noforcemaccel -nomsaa -stretchaspect -freq <refreshrate>`
   - `-noforcemparms -noforcemspd -noforcemaccel -nomsaa -freq <refreshrate>`
   - `-noforcemparms -noforcemaccel -nomsaa -stretchaspect -freq <refreshrate>`
   - `-noforcemparms -noforcemaccel -nomsaa -freq <refreshrate>`
   - `-noforcemparms -nomsaa -strectchaspect -freq <refreshrate>`
   - `-noforcemparms -nomsaa -freq <refreshrate>`
   
### Launch Option References:
   - A complete list of command line options for Gold Source Engine (HL1)
      - https://developer.valvesoftware.com/wiki/Command_Line_Options#Goldsource_Games
   - HL1 Engines Input Code
      - https://github.com/ValveSoftware/halflife/blob/5d761709a31ce1e71488f2668321de05f791b405/cl_dll/inputw32.cpp
   - Microsoft Windows **Mouse Threshold** Definitions
      - https://technet.microsoft.com/en-us/library/cc978667.aspx
      - https://technet.microsoft.com/en-us/library/cc978665.aspx

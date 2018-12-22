## In-Game Commands
The following covers a set of commonly used commands and those usually enforced by servers and leagues.

### Recommended Settings
   - **fps_max** "99.5"
      - This value when set to 99.5 will clamp the max fps to 100 in-game.
   - **rate** "100000"
      - Most servers can limit this however the maximum allowable setting is 100000 which will work regardless of the server you are on.
   - **cl_cmdrate** "105"
      - To reduce the impacts of choke/loss, set this to fps_max + 5. If you do not set it to +5 you will get red dots in net_graph 1 during longer sessions.
   - **cl_updaterate** "100" 
      - Should be equal to or above the fps_max value, has a maximum of 102)
   - **ex_interp** "0"
      - Automatically sets the appropriate interpolation value based on the updaterate, the formula use is 1/<updaterate>.
   - **gl_vsync** "0"
      - This disables vertical synchronization and will allow you to get FPS values above your monitors refresh rate, if you have a high refresh rate monitor (100hz, 120hz, 144hz) you might enjoy playing with it on.
   - **cl_weather** "0"
      - Disables ingame weather effects such as rain on de_aztec. May improve fps.
   - **gl_fog** "0"
      - Disables in game fog effects. May improve fps.
   - **m_rawinput** "1"
      - This enables raw input for your mouse and is intended to provide the game with the most accurate data directly from your mouse.
   - **cl_dlxmax** "128"
      - This may improve the overall experience in-game by reducing some of the network overhead.
   - **cl_filterstuffcmd** "1"
      - This command helps prevent servers and their admins from manipulating certain settings that may impact your game.
   - **hud_fastswitch** "1"
      - Enables fast weapon switching
   - **cl_dynamiccrosshair** "0"
      - Disables dynamic crosshair

For a 5v5 competitive and legal user configuration see [userconfig.cfg](userconfig.cfg)
- Download this file, review and edit the settings then place it in your Counter-Strike folder
   - `C:\Program Files (x86)\Steam\steamapps\common\Half-Life\cstrike`
- The settings in this file shouldn't be changed except those added by you or the ones in the user preferences section.
- **This user configuration will be run everytime you start the game and ensure you have the proper settings each time.**

### Network Settings
   - **rate** - This is how many bytes per seconds the server send to the client.
      - Range: 1000-100000, as of 2013 the **max allowable rate setting is 100000**, previously it was limited to 20000.
   - **cl_cmdrate** - Packets/updates per second sent from the client to the server.
      - Range: 30-unlimited, this setting is typically set to your fps_max +5 to reduce loss. e.g. 105 if your fps is 100.
   - **cl_updaterate** - Max allowable packets/updates the client can receive from the server.
      - Range: 20-102, as of 2013 the **max allowable updaterate is 102**, previously had a limit of 100.
   - **ex_interp** - The amount of time in seconds to interpolate in between each successive update. The default value is 0.1 (100ms)
      - Put `ex_interp "0"` into your userconfig.cfg to automatically set the ideal interpolation value that is based on your updaterate.
      - https://developer.valvesoftware.com/wiki/Lag_compensation
   - **cl_allowupload** - Defines whether your client will allow uploads such as sprays, or other custom content.
   - **cl_allowdownload** - Defines whether your client will allow downloads such as maps and models when connecting to a server.
   - **cl_download_ingame** - Enables the download of players custom sprays while playing.
   - **cl_dlxmax** - This defines determines the fragment size for chunks of player decals that are downloaded while playing the game.
      - This may range from 16 to 1024, as of 2013 the default value is 512, whereas previously it was 128.
   - **net_graph** - This allows you to place a network graph on your heads up display (HUD) and may give indication of any network issues such as loss and choke, it also displays your frames per second (fps). There are a few different displays for this setting, values, 0,1,2,and 3, a value of 3 provides the most simplistic view of that information.
   - **net_graph_pos** - Determines where on the HUD the net graph is located, right (0), center (1), and left (2).

### Video Settings
   - **gl_vsync** - Enables (1) or disables (0) vertical synchronization.
   - **gl_ansio** - Sets the amount of anisotropic filtering to apply, default x16 (16), turning this off (0) may improve performance.
   - **fps_max** - Set the maximum frames per second, default: 100.
      - A value higher than 100 can impact the game physics such as the speed at which you recover after falling from a jump. Low values can increase the rate at which bullets shoot.
   - **cl_weather** - This can be used to control the appearance of weather such as rain, default setting is (1), other options include 2 and 3 to add intensity to the weather on maps such as de_aztec.
      - Setting this to disabled (0) will improve overall performance.
   - **gl_fog** - Toggles whether fog is displayed for maps that use it, no restart is required. Default: Enabled (1)
      - Disabling this may improvement performance.
   - **cl_showfps** - Toggles an on screen display of the current fps. Default: Disable (0), Enabled (1)
   
### Audio
   - **snd_noextraupdate** - Enabled (1), Disabled (0). Default: 1 (Enabled)
      - This is a relatively new setting released in the series of 2013 updates, it changes how the audio is handled which should give performance on newer computers. If you have an older computer and performance issues, you may try to disable it.
   - **volume** - Controls the volume of ingame sounds such as gunshots and footsteps.
   - **voice_enable** - Enables (1) or disables (0) voice communication completely.
      - Many players disable this as it reduces the distractions in game and network overhead when transmitting voice communications. Especially if you're already using a voice comm such as ventrilo, mumble, or teamspeak.
   
### Gameplay
   - **cl_dynamiccrosshair** - Allows you to enable (1) or disable (0) the dynamic crosshair settings. 
      - When enabled the crosshair will change size to give indication of your accuracy. When you are moving or jumping it will get larger to indicate your shots will be less accurate when moving, when standing still or crouched the crosshair will get smaller.
      - If you are new to the game this may be beneficial to have on until you are comfortable with the game mechanics.
   - **hud_fastswitch** - This setting toggles fast weapon switch and has 3 values, 0, 1 and 2. For quick switch most people use values 1 or 2. Value 1 will allow you to use the scroll wheel to select your gun whereas 2 will not and only allow the numbered keys to select and switch to the weapon immediately.
   - **cl_sidespeed** - Defines the clients maximum allowable speed when moving sideways, this is also controlled by the server. Default: 400
      - These values should all be identical otherwise you will experience unusual movement.
   - **cl_backspeed** - Defines the clients maximum allowable speed when moving backwards, this is also controlled by the server. Default: 400
      - These values should all be identical otherwise you will experience unusual movement.
   - **cl_forwardspeed** - Defines the clients maximum allowable speed when moving forwards, this is also controlled by the server. Default: 400
      - These values should all be identical otherwise you will experience unusual movement.
      
### Mouse
   - **m_rawinput** - Toggles the use of mouse raw input option, enabled (1) and disabled (0). Default: Disabled
   - **m_customaccel** - Enables (1) or disables (0) built in acceleration settings, default is disabled (0)
   - **m_customaccel_exponent** - Mouse move is raised to this power before being scaled by scale factor, default is 1
   - **m_customaccel_max** - Defines the max upper limit of the acceleration scale, default is 0 (unlimited)
   - **m_customaccel_scale** - Defines the multiplier scale for the accleration curve, default is 0.04
   
## References
   - A nearly complete listing of available commands, not all 2013 updates are reflected.
      - http://txdv.github.io/cstrike-cvarlist/
   - A list of Source Engine commands, many commands are the same so they are used as a reference.
      - https://developer.valvesoftware.com/wiki/Console_Command_List

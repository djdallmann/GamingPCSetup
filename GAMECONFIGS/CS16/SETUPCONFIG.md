## Setting up your Counter-Strike CS 1.6 configuration
The following describes the process for selecting and building the ideal configuration that is competitive, legal and tournament ready.

1. **Load the base configuration file** that comes with CS 1.6, **if you have literally just installed the game and haven't touched the configuration in anyway then you're ready to go.**
   - Otherwise go to your Counter-Strike folder `C:\Program Files (x86)\Steam\steamapps\common\Half-Life\cstrike`
   - Delete any files named **autoexec.cfg, userconfig.cfg and config.cfg**
   - Open your Steam library and right-click Counter-Strike and go to Properties
   - Go to the **Local Files** tab then press the button **VERIFY INTEGRITY OF GAME FILES...**, wait for the process to complete.
2. Download the supplied [userconfig.cfg](userconfig.cfg) from this repository and place the file in your Counter-Strike folder.
   - `C:\Program Files (x86)\Steam\steamapps\common\Half-Life\cstrike`
   - The commands in this configuration file are recommended which modify default values in the game to provide an ideal configuration and experience.
   - For more information on the commands see [Section 3 - In-game Commands](GAMECOMMANDS.md)
3. Next you'll want to choose the Steam game's **launch options** that you'll be using.
   - For a list of available and recommended options see [Section 1 - Steam Launch Options](STEAMLAUNCH.md) .
   - To set the launch options open your Steam library right-click Counter-Strike and go to Properties, in the General tab press the **SET LAUNCH OPTIONS..** button then enter the values you've selected.
4. Launch Counter-Strike and make any additional user preferences using the previous sections as a guide.
   - [Counter-Strike 1.6 Configuration Guide](README.md)
5. Once you are satisifed with the configuration, make a copy of your config.cfg in the Counter-Strike folder.
   - You can also save a copy of the file while in-game, open the console  with `~` then type `writecfg <myfilename>` it will then save the config file with that name in your cstrike folder. You can then execute it at anytime from the console using `exec <myfilename>`

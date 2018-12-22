## In-Game Menu Options
This section covers some the available in-game menu options

### Recommended
The following are recommended changes from the default configuration for competitive play:
   - **Multiplayer > Name**
   - **Multiplayer > Crosshair Appearance > Size** - Start with Medium, then adjust based on your personal preference.
   - **Options > Multiplayer > Advanced > Buy menu type** - Use VGUI if you are new to the game, otherwise try using Old style menus once you are familiar with the different weapons and player models.
   - **Options > Multiplayer > Advanced > Automatically switch to picked up weapons (if more powerful)** - Disable
   - **Options > Multiplayer > Advanced > Center Player Names** - Disable
   - **Options > Multiplayer > Advanced > Auto-help** - Disable
   - **Options > Multiplayer > Advanced > Radar type** - Solid, improves visbility of players on radar.
   - **Options > Keyboard > Bind > Jump** - Bind jump to either mouse wheel scroll up or down.
   - **Options > Mouse > Joystick** - Disable
   - **Options > Mouse > Joystick look** - Disable
   - **Options > Mouse > Auto-Aim** - Disable, most servers don't support this feature.   
   - **Options > Mouse > Raw Mouse Input** - Enable, this should give the most consistent mouse movement.
   - **Options > Mouse > Mouse Sensitivity** - An average sensitivity typically ranges between 1.4 and 2.9 on a 400dpi mouse.
   - **Options > Audio > Sound effects volume** - You may need to lower this from the default value, jump in-game and test.
   - **Options > Video > Renderer** - OpenGL
   - **Options > Video > Resolution** - Many players favor using lower resolutions such as 640x480 or 800x600, however with modern video cards you may get better performance and mouse response on higher resolutions such as when using your monitors native resolution.
   - **Options > Video > Wait for vertical sync** - Most players disable this for additional performance and mouse response, if you have raw input disabled and this is off your mouse may tend to jump around randomly.
   - **Options > Video > Enable HD Models if available** - Disable, may improve overall rendering performance
   - **Options > Video > Allow custom addon content** - Disable, will reduce content transfered over the network during game play.
   - **Options > Video > Low video quality** - If you are experiencing performance issues, try this. Otherwise do not enable.
   - **Options > Video > Brightness** - Many players will set this value to the maximum, may improve visibility in dark areas of the game. This is personal preference.
   - **Options > Video > Gamma** - Many players will set this value to the maximum, may improve visibility and colors. This is personal preference.

See below for a more complete list of available options

### Multiplayer
   - **Name** - The name that will be displayed in-game that other players will view.
   - **Crosshair Appearance**
      - **Size:** Small, Medium, Large and Auto
         - This is personal preference, large may increase visibility when spraying your bullets while small may provide a better guide when performing single shot or bursts.
      - **Color:** Green, Red, Blue, Yellow, Light Blue
         - This can customized via the command line using RGB color values, (default green: cl_crosshair_color 50 250 50)
      - **Translucent** - Determines whether the crosshair is solid or translucent, a solid crosshair may be easier to see.

### Options > Multiplayer > Advanced
   - **Time before dead bodies disapear** - Setting this to a lower value may increase overall performance by removing old in-game entities (dead player models) more quickly.
   - **Multiplayer decal limit** - Alters the number of allowable decals viewable on-screen (Spray logo, bullet holes, grenade scorch, blood on ground), setting this to a lower value may improve performance.
   - **Max Shells** - Alters the number of ammunition shells that can leave the players gun model at one time, lowering this value can give advantage by eliminating on-screen distractions while shooting.
   - **Max Smoke Puffs** - Alters the number of smoke puffs from grenades and bullets hitting the wall which will give advantage in visibility to the player who has the smaller value.
   - **Smoke Gas Grenade spriate quality** 
      - **Best looking, slowest** - This setting offers the best graphical look of the smoke and is **required by most leagues.**
      - **Medium quality** - This setting offers a mix of performance and good looking smoke sprites.
      - **Worst looking, fastest** - This setting provides the worst looking smokes but the best performance.
   - **Weapon alignment** - Allows you to choose whether your weapon is left or right handed, this is personal preference.
   - **Buy menu type**
      - **VGUI menus** - Offers a graphical representation of the buy menu, people coming from Counter-Strike: Global Offensive (CSGO) may prefer this method.
      - **Old style menus** - Offers a text based representation of the menu, many veterans prefer this method over the other.
   - **Automatically switch to picked up weapons (if more powerful)** - Allows weapons to be switched automatically when they are more powerful, most people turn this off so they are in control of when their weapon is switched.
   - **Center Player Names** - This controls where the players name is displayed on your screen when the crosshair is focused on another player characters.
   - **Auto-help** - Gives player hint messages throughout the game.
   - **Automatically take end-game screenshots** - Will automatically take screenshots at the end of maps.
   - **Observer Crosshair** - This enables the crosshair in Free Look spectator mode.
   - **Radar Type** - **Solid** provides better visibility of the radar by having a solid background, where as **translucent** provides a more esthetic appearance.
   
### Options > Keyboard
This section covers the available in-game options for keyboard binds for specific actions, these are primarly preference.
   - Most commonly the **duck and jump binds are bound to mouse wheel scroll** to assist in executing certain techniques such as bunny hopping or crouch hopping.
   - **Binding scroll wheel to duck was not allowed in any professional 5v5 tournaments** which assisted in reducing crouch hopping exploits (reduced sound of footsteps while running). 
   - Although crouch hopping may have been allowed in leagues and tournaments it wasn't allowed with scroll wheel bound to duck since it made execution of the technique extremely easy to master and take advantage of.
   
### Options > Mouse
   - **Reverse mouse** - Reversed mouse up/down axis
   - **Mouse look** - Enables the use of a computer mouse to rotate the view in-game
   - **Mouse filter** - Smoothes mouse movement, not a commonly used setting. Most players prefer more raw/unmodified mouse movement.
   - **Joystick** - Enables the use of a joystick
   - **Joystick look** - Enables the use of a joystick to rotate the view in-game
   - **Auto-Aim** - Aims at enemies automatically, normally sv_cheats is required for this to work which isn't enabled by default on most servers.
   - **Raw Mouse Input** - Uses unmodified output directly from the mouse vs from Microsoft Windows, this setting should provide increase mouse movement consistency while playing but not everyone prefers to use it.
   - **Mouse sensitivity** - Determines what multiplier to use when scaling mouse sensitivity, the higher the value, the quicker your mouse will rotate your players view. 
      - A higher value may make it more difficult to aim consistently where as a low value may improve consistency but may be more difficult to make quick movements or perform 180s ingame if someone is shooting you in the back.

### Options > Audio
   - **Sound effects volume** - Controls the volume of sound effects in-game, such as shooting, footsteps.
   - **Mp3 Volume** - Controls the volume of background audio tracks.
   - **Sound Quality** - High provides the best sound quality where as Low may provide better performance but low quality sounds.
   
### Options > Video
   - **Renderer** - OpenGL or Software mode, OpenGL should provide improved performance when available.
   - **Resolution** - The desired in-game resolution, many players used to prefer lower resolutions such as 640x480 or 800x600. On newer versions of windows you might get better performance on your monitors native resolution or a higher resolution than those indicated above.
   - **Display Mode** - Normal (4:3) or Widescreen (16:9,16:10), this is directly related to the setting above. Many prefer Normal (4:3) resolutions, however you may prefer Widescreen to display the game in your monitors native resolution.
   - **Run in a window** - Allows you to run CS in a window, not typically recommended due to potential performance impacts.
   - **Wait for vertical sync** - Allows you to enable or disable vertical syncronization, most turn this off.
      - If you have mouse raw input off, you might get better mouse movement experience with vsync on due to the changes to the game in 2013, but due to the way vsync works you might experience small delays in movement unless you have a high monitor refreshrate and powerful PC.
   - **Enable HD Models if available** - Allows you to enable high definitions player models.
   - **Allow custom addon content** - Allows you to control whether custom addon content is allowed such as downloading other player sprays to be displayed in-game.
   - **Low video quality** - This setting modifies a few different settings on the backend such as a lower texture quality, nomsaa/ nofbo.
   - **Brightness** - Defines the in-game brightness, many players put this to the highest value to increase visilbility.
   - **Gamma** - Defines the in-game gamma settings, many players put this to the highest value to increase visilbility.

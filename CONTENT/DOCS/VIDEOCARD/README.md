## Dedicated video card drivers and settings
Download the latest drivers, install and configure your settings for ideal and consistent performance

### Windows 10 GPU Graphics Performance Preference
1. **Once your videocard drivers are installed** (NVIDIA and/or AMD) follow these steps **for each game you play.**
2. Right-click the desktop go to **Display Settings**, scroll down to **Graphics settings**.
3. For Metro/Windows Store Games choose **Universal app** from the drop-down *otherwise* select **Classic app** and then press **Browse**, then navigate to your game executable path. e.g. `C:\Program Files (x86)\Steam\steamapps\common\Half-Life\hl.exe`
4. Once a game is added to your graphics preference list, left click the game go to **Options** and choose **High performance.**

### NVIDIA
1. Go to https://www.geforce.com/drivers and download the latest applicable drivers for your video card
2. Install the drivers, during the installation choose custom installation, check **Perform a clean install** and **uncheck all of the following** if you don't plan to use them:
   - HD Audio Driver
   - 3D Vision Driver
   - 3D Vision 
   - NVIDIA Geforce Experience
3. Complete the rest of the steps and wait for the process to complete
4. After the installation is complete right click on your desktop and choose NVIDIA Control Panel
5. Go to **Adjust image settings with preview**, then select **Use my preference emphasizing: Performance**
6. Go to Resolution set the refresh rate to 120hz or higher for your desktop experience if your monitor is capable.
   - A lower value may be fine for desktop use and most games will allow you to override this setting via game launch option. e.g. -freq 144
7. Go to **Adjust desktop size and position** and choose **Perform Scaling on GPU**, and choose **No Scaling**
8. Under **Manage 3D Settings** then **Program Settings**, select your game from the list then perform the following: 
   - **Power management mode**: Leave this at **Optimal Power globally** and set this to **Prefer Maximum Performance** for your game.
9. Avoid adjusting any of the color settings initially such as Digital Vibrance, Brightness, or Contrast. Ensure your gaming experience is running smoothly first for a few days or up to a week, then slowly start to add new features to your build.
   - Games may also provide options ingame for improving visual effects, colors or quality, try these first.
10. Leave all other settings at the NVIDIA defaults. [See Gaming Configurations](../GAMECONFIGS/README.md)

Many guides will recommend changing **Maximum pre-rendered frames** but not every PC or game will behave the same with it at a low value even on high end PCs. Many gaming professionals use the default setting and still perform at the highest levels. When in doubt benchmark the impacts with MSI Afterburner and GPUView.

### AMD
To be completed

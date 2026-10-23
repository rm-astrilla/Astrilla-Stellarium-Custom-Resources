Here are the instructions for installing custom shaders from ReShade. The version of ReShade used here is the latest one (6.8.0), which can be downloaded from the official ReShade website: https://reshade.me/, or you can access the EXE file directly from this repository folder.

Once installed, you’ll see a menu where you can select the application you want to apply the shader to. In this example, Stellarium. Next, select the graphics rendering option—choose DirectX 3D or OpenGL (if your device has an integrated GPU with sufficient specifications). In my case (I don’t have an integrated GPU), select the DirectX 9/10/11 rendering option, which requires you to run Stellarium in ANGLE mode (please check the EXE options in your Stellarium installation folder). This is more stable if you’re using a mid-range laptop like mine.

Next, you’ll see the shader pack download options. Select all (or choose whichever ones you prefer). Alternatively, if you’d like to use the configuration I’ve set up, check the ‘ReShade-preset.ini’ file. Copy this file to replace the default one in your ReShade installation (which is located in the same folder as your Stellarium installation).

Once you’ve downloaded it, open Stellarium and wait a few moments for the ReShade menu to load. According to the instructions, the default key to activate the ReShade menu is “Home.” However, if you don’t have or can’t access the Home key on your keyboard, change the KeyOverlay line in the “reshade.ini” file to: KeyOverlay=33,0,0,0

Restart the program, and ReShade is ready to use, depending on which graphics rendering option is selected.

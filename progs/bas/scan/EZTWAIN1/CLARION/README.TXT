1. Copy the "include" file eztwain.clw from \\EZTwain\Clarion into the Clarion LIBSRC folder eg. C:\Clarion6\LIBSRC
2. Copy the Clarion-specific LIB file Eztw32.lib to your project folder (the folder that your .app is located in)
3. In your .app, insert the following in Global embeds, "Before Global Includes" section:   INCLUDE('eztwain.clw')
4. Edit your project settings and in the "Library, object and resource files" section click "Add File" and point it at the Eztw32.lib file (per 2 above)
5. Put the eztw32.dll either in the System32 folder, or in the folder with your application's .EXE file.
5. Now call whatever Eztwain functions that you require in your source code.


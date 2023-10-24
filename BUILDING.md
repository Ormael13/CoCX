# **Building SWF file**

Generally, you want 3 things.
- Git & GitHub account to checkout the project and create pull requests. YOU NEED TO DOWNLOAD GIT CLIENT FIRST!
- SDK (**very** hard to find nowadays, but it's possible. One option will be described later in the guide.)
- Some IDE to compile the project with.
- **Debug** version of Adobe Flash Player to start the game with tracing options and (maybe?) better error output. Not sure if there's any other difference.

## *Windows*
There are 2 known IDEs for CoC, which have existing projects in the repository:
- FlashDevelop.
  - It's free.
  - It's old, so some things are implemented in a weird way.
  - It misses some modern features like code analysis.
  - At the moment (05.2022), it provides an easy way to download both FLEX SDK and the **debug** version of Adobe Flash Player.
- IntelliJ IDEA (Ultimate).
  - It's paid, BUT. You can get a one-year student license if are a student. Also, there *was* some trick for resetting the trial period, but I'm not sure if it still works and what it requires. Maybe some people on Discord can help you.
  - It can even compile APKs, but I don't know how it's done. Ask Jtex to add info here.
  - It contains a lot of modern functions. Code indexing, analysis, regex search, and much more. The warnings often help to notice some of the dumbest bugs.
  - On the other hand, some of its features can be confusing at the start. But it's not a big problem.

If you are using FlashDevelop, I'd recommend to also install Visual Studio Code (with its ActionScript extension) for project search (with regex) and modern editing features. It has neither code analysis (I didn't manage to set up the extension to index the project) nor compile functions, but it's still a good source editor.

VSCode also provides a very nice Git interface, and even some specific GitHub functions. (Committing and merging is much easier with the actual GUI compared to Git console...)

### FlashDevelop
1. Fork and checkout the repository. If you have VSCode installed, you can just point it to your fork in the starting window, it will download everything itself.
2. Download the **develompent** build of FlashDevelop from https://flashdevelop.org/downloads/builds/. Development builds allow installation of additional software (SDK) without extra manipulations.
    * Ignore the "You should install Adobe Flash Player before FlashDevelop" warning during installation.
3. Tools -> Install Software (AppMan).
    * **FlexSDK (OLD)** - 4.6.0. It includes AirSDK of the right version - 3.1.
    * **Flash Player (SA)** - Debug version of Adobe Flash Player, which shows convenient debug messages when something breaks the game.
4. Go to FlexSDK directory, usually "*%AppData%\Local\FlashDevelop\Apps\flexsdk\4.6.0\bin\\*". In **jvm.config** change line 31:
```
java.args=-Xmx384m -Dsun.io.useCanonCaches=false
```
384M will apparently be not enough for the compiler (that leads to the crash with garbage collector), so change it to a bigger value (1G or 2G, for example).

4. Open **Corruption-of-Champions-FD-STANDALONE.as3proj** file in the root folder of the repository. It will load the entire project.
5. In Project Properties -> SDKs add a new AS3 SDK. Select FlexSDK folder - "*%AppData%\Local\FlashDevelop\Apps\flexsdk\4.6.0\\*"
6. That's it, you can build the project! Right-click on the project in the right panel and hit 'Build'. The file 'CoC_debug.swf', if built correctly, will appear somewhere near or inside the project folder. 

### IntelliJ Idea
The main problem with it is that you still need the SDK, and you *can't* download it with IJ. So you need to find it somewhere else, or download it using FlashDevelop first. The same goes for Adobe Flash Player.

#### Direct link extracted from FD
https://fpdownload.adobe.com/pub/flex/sdk/builds/flex4.6/flex_sdk_4.6.0.23201B.zip

#### Flex SDK - without FD, EragonX method
You can download the 4.16.1 Flex SDK from [Apache](https://flex.apache.org/download-binaries.html), do not use the SDK Installer as it is broken.
The player (both regular and debug versions) can be downloaded from Xianxia discord server.

> Svalkash note: Although the method works in general, the provided SDK doesn't work for me. So here's a [version](https://github.com/brrritssocold/CoC-build-dependencies/tree/master/bin/flex) from Kitteh's mod. You (probably?) still need to add swfobject files to it and edit the xml...

Extract it to your location of choice.
Create a new environment variable `FLEX_HOME` and point it to the SDK folder e.g. 'C:\\files\apache-flex-sdk-4.16.1-bin'.
Edit the 'Path' variable and add an entry to `%FLEX_HOME%\bin`
Get the SWFObject Source code zip from [here](https://github.com/swfobject/swfobject/releases/tag/2.2) and place it as is in the SDK folder.
look for the `installer.xml` file and remove the 4 lines for swfobject.url (search for them) and replace with `<property file="${FLEX_HOME}/swfobject-2.2.zip"/>`

For mobile builds get the Harman AIR SDK for Flex Developers v 33.1 from [Harman](https://airsdk.harman.com/download) and extract it into the Flex SDK directory.
Create a new environment variable `AIR_HOME` and point it to the SDK folder e.g. 'C:\\files\apache-flex-sdk-4.16.1-bin'.
Edit the Path variable and add an entry to `%AIR_HOME%\bin`
####Adding new environment variables to windows:
```1. On the Windows taskbar, right-click the Windows icon and select System.
2. In the Settings window, under Related Settings, click Advanced system settings. 
3. On the Advanced tab, click Environment Variables. 
4. Click New to create a new environment variable. Click Edit to modify an existing environment variable. 
5. After creating or modifying the environment variable, click Apply and then OK to have the change take effect. 
```
#### IDEA configuration

>Important: if you encounter any errors with memory allocation during the build, use the above advice for FlashDevelop to increase max memory for SDK. 

The repository already contains a project for IJ Idea, but it needs to be adjusted for your system.
1. Download, install, activate the IDE: https://www.jetbrains.com/idea/
2. Install some extensions - Flash/Flex, Git toolbox, optionally a color theme to make everything look better.
3. Fork the repository and paste the link into IDEA, it will download it itself.
4. Now you can edit the project, but it probably has incorrect paths to SDKs. Open 'Project Structure' menu.
   * In 'Project' page, add the path to your FLEX SDK ("4.6.0" folder or something like that).
   * In 'Modules' page, for every build configuration go to 'Dependencies' tab and select your SDK again. You may delete some configurations if you don't need them.
5. Now, if everything is done right, IDEA should start indexing the project. It will take some time to complete.
6. On above panel, you can see the "*Build*", "*Run*" and "*Debug*" buttons. Building will (obviously) build an .swf file (somewhere in the project folder), and "Debug" will build and start the game with debugger, meaning you will be able to view the trace messages (which can be really useful sometimes). But here's the issue - the debug configuration near these buttons is not working yet. Edit it and set the paths to your SDK and debug player version.
7. (optional) If you don't want Liadri kill to you (by accidentally uploading your new IDEA configs), you can move them to a separate changelist.
8. (optional) IDEA tends to check some files before the commit, and it often takes a lot of time. Press "Show commit options" button above the commit message and remove the ticks to disable it.

## *Linux*

> It's possible?

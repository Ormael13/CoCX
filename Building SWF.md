# **Building SWF file**

## *Windows*
There are 2 known IDEs suitable for CoC:
- IntelliJ IDEA (Ultimate),
- FlashDevelop - free.

### FlashDevelop
1. Download the **develompent** build of FlashDevelop from https://flashdevelop.org/downloads/builds/. Development builds allow installation of additional software (SDK) without extra manipulations.
    * Ignore the "You should install Adobe Flash Player before FlashDevelop" warning during installation.
2. Tools -> Install Software (AppMan).
    * **FlexSDK (OLD)** - 4.6.0. It includes AirSDK of the right version - 3.1.
    * **Flash Player (SA)** - Debug version of Adobe Flash Player, which shows convenient debug messages when something breaks the game.
3. Go to FlexSDK directory, usually *%AppData%\Local\FlashDevelop\Apps\flexsdk\4.6.0\bin\\*. In **jvm.config** change line 31:
```
java.args=-Xmx384m -Dsun.io.useCanonCaches=false
```
384M will apparently be not enough for the compiler (that leads to the crash with garbage collector), so change it to a bigger value.

4. Open **Corruption-of-Champions-FD-STANDALONE.as3proj** file in the root folder of the repository. It will load the entire project.
5. In Project Properties -> SDKs add a new AS3 SDK. Select FlexSDK folder - *%AppData%\Local\FlashDevelop\Apps\flexsdk\4.6.0\\*
6. That's it, you can build the project!

## *Linux*

> It's possible to use IntelliJ IDEA Ultimate with Linux too. Maybe SDK installs will get easier.

If you're afraid of GUIs, it's possible through the terminal too.
1. You'll need the correct versions of SDKs - FlexSDK **4.6.0** with AirSDK **3.1**.
2. FlexSDK doesn't have installers for Linux (only for MacOS), so you'll need to compile them yourself.
3. As for Windows, change the memory limit for FlexSDK to something more realistic.
4. In the repository, */devTools/buildSwf.sh* contains the required compiler arguments for building the SWF file. Should be started from the root.
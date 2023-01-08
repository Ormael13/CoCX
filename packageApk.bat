@set AIRSDKDIR=C:\Marcin\Flash Games\CoC
@set CURDIR=%~dp0%
@set STOREPASS=123456
@set APKNAME=CoC-Mobile.apk
@set SWFNAME=CoC-Mobile.swf
@set PROJECT_FILE=%CURDIR%\CoC-Android.xml
%AIRSDKDIR%\bin\adt -package -target apk-captive-runtime -storetype PKCS12 -keystore %CURDIR%\coc.keystore -storepass %STOREPASS% %APKNAME% %PROJECT_FILE% -C %CURDIR% %SWFNAME% -C %CURDIR% devTools\icons

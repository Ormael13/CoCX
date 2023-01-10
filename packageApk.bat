@set AIRSDKDIR=C:\Marcin\Flash Games\CoC\Nowy Nowy Nowy
@set CURDIR=%~dp0%
@if {%CURDIR:~-1,1%}=={\} (@set CURDIR=%CURDIR:~0,-1%)
@set STOREPASS=123456
@set APKNAME=CoC-Mobile.apk
@set SWFNAME=CoC-Mobile.swf
@set PROJECT_FILE=%CURDIR%\CoC-Android.xml
call "%AIRSDKDIR%\bin\adt" -package -target apk-captive-runtime -storetype PKCS12 -keystore "%CURDIR%\coc.keystore" -storepass %STOREPASS% "%APKNAME%" "%PROJECT_FILE%" -C "%CURDIR%" "%SWFNAME%" -C "%CURDIR%" devTools\icons
@pause

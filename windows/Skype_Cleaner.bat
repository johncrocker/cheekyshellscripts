@echo off
cd c:\
cd %USERPROFILE%\AppData\Roaming\Skype\%1
del main.db
del Pictures
del media_messaging
del voicemail
cd ..
del "My Skype Received Files"
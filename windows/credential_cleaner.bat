@echo off
cmdkey.exe /list > "%TEMP%\List.txt"
findstr.exe Target "%TEMP%\List.txt" > "%TEMP%\tokensonly.txt"
FOR /F "tokens=1,2 delims= " %%G IN (%TEMP%\tokensonly.txt) DO cmdkey.exe /delete:%%H
del "%TEMP%\list.txt","%TEMP%\tokensonly.txt" /s /f /q

Pause

for /F "tokens=1,2 delims= " %G in ('cmdkey /list ^| findstr Target') do  cmdkey /delete %H
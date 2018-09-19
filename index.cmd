@echo off

:: Set starting ID here
set id=266700

:bk
echo %id%

:: Invoke BaiduPCS-Go to test if the appid avaliable
BaiduPCS-Go.exe config set -appid=%id% > nul
BaiduPCS-Go.exe ls 
set /a id+=1

goto bk

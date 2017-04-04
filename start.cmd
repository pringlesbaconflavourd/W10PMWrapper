@echo off
title CortexPE - PocketMine Looping Wrapper for Windows 10
color b
cd /d %~dp0
tasklist /FI "IMAGENAME eq mintty.exe" 2>NUL | find /I /N "mintty.exe">NUL
if %ERRORLEVEL% equ 0 (
    goto :loop
) else (
	echo """""""""""""""""""""""""""""""""""""""""""""
	echo "   ____           _            ____  _____ "
	echo "  / ___|___  _ __| |_ _____  _|  _ \| ____|"
	echo " | |   / _ \| '__| __/ _ \ \/ / |_) |  _|  "
	echo " | |__| (_) | |  | ||  __/>  <|  __/| |___ "
	echo "  \____\___/|_|   \__\___/_/\_\_|   |_____|"
	echo "                                           "
	echo " PocketMine Looping Wrapper for Windows 10 "
	echo """""""""""""""""""""""""""""""""""""""""""""
    goto :start
)

:loop
tasklist /FI "IMAGENAME eq mintty.exe" 2>NUL | find /I /N "mintty.exe">NUL
if %ERRORLEVEL% equ 0 (
    goto :loop
) else (
	echo "INFO > Server Stopped"
	goto :start
)

:start
if exist bin\php\php.exe (
    set PHP_BINARY=bin\php\php.exe
) else (
    set PHP_BINARY=php
)
if exist PocketMine-MP.phar (
    set POCKETMINE_FILE=PocketMine-MP.phar
) else (
    if exist src\pocketmine\PocketMine.php (
        set POCKETMINE_FILE=src\pocketmine\PocketMine.php
    ) else (
        msg * "ERROR > Couldn't find a valid PocketMine-MP installation..."
        pause
        exit 1
    )
)
echo "INFO > Server Started"
if exist bin\php\php_wxwidgets.dll (
    %PHP_BINARY% %POCKETMINE_FILE% --enable-gui %*
) else (
    if exist bin\mintty.exe (
        start "" bin\mintty.exe -o Columns=88 -o Rows=32 -o AllowBlinking=0 -o FontQuality=3 -o Font="Consolas" -o FontHeight=10 -o CursorType=0 -o CursorBlinks=1 -h error -t "PocketMine-MP" -i bin/pocketmine.ico -w max %PHP_BINARY% %POCKETMINE_FILE% --enable-ansi %*
    ) else (
        %PHP_BINARY% -c bin\php %POCKETMINE_FILE% %*
    )
)

goto :loop

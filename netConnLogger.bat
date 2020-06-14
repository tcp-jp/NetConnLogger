@ ECHO OFF

:: Net connection logger. 

:init
:: Preliminary Setup - Window config
mode con: cols=95 lines=13
:: Preliminary Setup - Address settings
IF NOT [%1] == [] SET address=%1
IF [%1] == [] SET address=8.8.8.8
echo Testing connection to %address%.

:: Preliminary Setup - File System/ Logging
SET first=True
SET employer=EXAMPLE
SET filePath='C:\%employer%\NetworkLogs\'
IF NOT EXIST %filePath:~1,-1% MKDIR %filePath:~1,-1% 
echo Testing connection to %address%. >> %filePath:~1,-1%Log-%date:/=-%.log
:: Preliminary Setup Complete

:: Main
:main
cls
call :banner
IF NOT DEFINED status SET status=Generating
ECHO 				Current status : %status%
ping %address% -n 2 | find "Reply">NUL && SET connected=True&& goto connected
ping %address% -n 2 | find "failed">NUL && SET connected=False&& goto disconnected

:connected
cls
color 2
IF %first%==True echo Initial connection status : connected.>> %filePath:~1,-1%Log-%date:/=-%.log
IF %first%==True echo Initial connection status : connected.
SET first=False
IF %connected%==False echo Reconnected at %time% >> %filePath:~1,-1%Log-%date:/=-%.log
SET connected=True
SET status=Connected
goto main

:disconnected
cls
color 4
IF %first%==True echo Initial connection status : disconnected.>> %filePath:~1,-1%Log-%date:/=-%.log
IF %first%==True echo Initial connection status : disconnected.
SET first=False
IF %connected%==True echo Connection lost at %time% >> %filePath:~1,-1%Log-%date:/=-%.log
SET connected=False
SET status=Disconnected
goto main


:banner 
ECHO.
ECHO.
ECHO  #     #               #####                       #                                          
ECHO  ##    # ###### ##### #     #  ####  #    # #    # #        ####   ####   ####  ###### #####  
ECHO  # #   # #        #   #       #    # ##   # ##   # #       #    # #    # #    # #      #    # 
ECHO  #  #  # #####    #   #       #    # # #  # # #  # #       #    # #      #      #####  #    # 
ECHO  #   # # #        #   #       #    # #  # # #  # # #       #    # #  ### #  ### #      #####  
ECHO  #    ## #        #   #     # #    # #   ## #   ## #       #    # #    # #    # #      #   #  
ECHO  #     # ######   #    #####   ####  #    # #    # #######  ####   ####   ####  ###### #    # 
ECHO.
ECHO.
goto :eof                                                                                                                   

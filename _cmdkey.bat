@ECHO OFF
REM cmdkey /generic:git:https://github.com /user:zx9229   /pass:ÃÜÂë
REM cmdkey /generic:targetname             /user:username /pass:password

CMDKEY   /LIST:git:https://github.com

SET /P INPUT=ÒªÉ¾³ý¸ÃÆ¾Ö¤Âð£¿[y/N]: 

IF /I "%INPUT%"=="y" (
CMDKEY /DELETE:git:https://github.com
ECHO.
) ELSE (
ECHO.
ECHO Î´É¾³ý
ECHO\
)

PAUSE

@ECHO OFF
REM cmdkey /generic:git:https://github.com /user:zx9229   /pass:����
REM cmdkey /generic:targetname             /user:username /pass:password

CMDKEY   /LIST:git:https://github.com

SET /P INPUT=Ҫɾ����ƾ֤��[y/N]: 

IF /I "%INPUT%"=="y" (
CMDKEY /DELETE:git:https://github.com
ECHO.
) ELSE (
ECHO.
ECHO δɾ��
ECHO\
)

PAUSE

@SET SCRIPTS__DIR=%~dp0
@SET SCRIPTS_NAME=%~nx0
@SET SCRIPTS_NAME=%~n0%~x0

@ECHO SCHTASKS /Create /TN HEXO_SERVER_BAT /RU SYSTEM /SC ONSTART /TR "%SCRIPTS__DIR%%SCRIPTS_NAME%"

%USERPROFILE%\AppData\Roaming\npm\hexo.cmd  server  --port=4000  --cwd=%SCRIPTS__DIR%

@REM  Windows下设置开机自启动程序(不依赖账户登录)
@REM  思路：创建一个任务计划，它以系统账户(SYSTEM)运行，它在开机时(ONSTART)运行。无需账户登录。
@REM  命令： `SCHTASKS /Create /TN 任务名          /RU SYSTEM /SC ONSTART /TR 程序的路径和文件名`。
@REM  示例： `SCHTASKS /Create /TN HEXO_SERVER_BAT /RU SYSTEM /SC ONSTART /TR "%SCRIPTS__DIR%%SCRIPTS_NAME%"`。
@REM  解释：创建一个任务计划，名为`HEXO_SERVER_BAT`，运行命令是`%SCRIPTS__DIR%%SCRIPTS_NAME%`。
@REM  注意：如果需要更细致的设置，请在`任务计划程序`里面进行设置。

@REM  最新情报：
@REM    请使用指定用户(比如【ZHANG-LAPTOP\zhang】)；
@REM    不管用户是否登录都要运行；
@REM    使用最高权限运行。

@echo off
chcp 65001 >nul
echo ========================================
echo   批量文件夹重命名工具 - 启动脚本
echo ========================================
echo.
echo 正在启动应用程序...
echo.

REM 使用Maven运行
call mvnw.cmd clean javafx:run

pause

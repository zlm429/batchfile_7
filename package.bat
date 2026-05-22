@echo off
chcp 65001 >nul
echo ========================================
echo   批量文件夹重命名工具 - 打包脚本
echo ========================================
echo.
echo 正在打包应用...
echo.

REM 先编译打包JAR
call mvnw.cmd clean package -DskipTests

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo JAR打包失败！
    pause
    exit /b 1
)

echo.
echo JAR打包成功！
echo.
echo 正在使用jpackage打包可执行文件...
echo.

REM 使用jpackage打包
call mvnw.cmd jpackage:jpackage

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo jpackage打包失败！
    echo 请确保已安装 JDK 14+ 并配置好环境变量
    pause
    exit /b 1
)

echo.
echo ========================================
echo   打包完成！
echo ========================================
echo.
echo 输出目录: target\dist\
echo.
echo Windows: 批量文件夹重命名工具-1.0.0.exe
echo.
echo 注意：首次运行可能需要安装依赖库
echo.
pause

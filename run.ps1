# 批量文件夹重命名工具 - PowerShell启动脚本

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  批量文件夹重命名工具 - 启动脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "正在启动应用程序..." -ForegroundColor Green
Write-Host ""

# 使用Maven运行
.\mvnw.cmd clean javafx:run

Write-Host ""
Write-Host "程序已退出" -ForegroundColor Yellow
Pause

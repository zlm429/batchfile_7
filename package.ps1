# 批量文件夹重命名工具 - PowerShell打包脚本

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  批量文件夹重命名工具 - 打包脚本" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 检查Java版本
Write-Host "检查Java环境..." -ForegroundColor Yellow
$javaVersion = java -version 2>&1
if ($javaVersion -match "version `"(\d+)") {
    $version = [int]$Matches[1]
    if ($version -lt 14) {
        Write-Host "错误：需要Java 14或更高版本，当前版本: $version" -ForegroundColor Red
        pause
        exit 1
    }
    Write-Host "✓ Java版本: $version (满足要求)" -ForegroundColor Green
} else {
    Write-Host "错误：未找到Java，请先安装JDK 14+" -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "步骤1: 编译打包JAR文件..." -ForegroundColor Yellow

# 编译打包
& .\mvnw.cmd clean package -DskipTests

if ($LASTEXITCODE -ne 0) {
    Write-Host "错误：JAR打包失败！" -ForegroundColor Red
    pause
    exit 1
}

Write-Host "✓ JAR打包成功！" -ForegroundColor Green
Write-Host ""

# 查找JAR文件
$jarFile = Get-ChildItem -Path target -Filter "batchfile_app-*.jar" -Exclude "*.original" | Select-Object -First 1

if (-not $jarFile) {
    Write-Host "错误：找不到JAR文件！" -ForegroundColor Red
    pause
    exit 1
}

Write-Host "找到JAR文件: $($jarFile.Name)" -ForegroundColor Green
Write-Host ""
Write-Host "步骤2: 使用jpackage打包可执行文件..." -ForegroundColor Yellow
Write-Host ""

# 创建输出目录
New-Item -ItemType Directory -Force -Path "target\dist" | Out-Null

# 执行jpackage
$jpackageArgs = @(
    "--input", "target",
    "--name", "批量文件夹重命名工具",
    "--main-jar", $jarFile.Name,
    "--main-class", "com.rt.batchfile_app.BatchfileAppApplication",
    "--dest", "target\dist",
    "--app-version", "1.0.0",
    "--vendor", "RT",
    "--java-options", "--add-modules",
    "--java-options", "javafx.controls,javafx.fxml"
)

Write-Host "执行命令: jpackage $($jpackageArgs -join ' ')" -ForegroundColor Gray
Write-Host ""

& jpackage @jpackageArgs

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "错误：jpackage打包失败！" -ForegroundColor Red
    Write-Host "可能原因：" -ForegroundColor Yellow
    Write-Host "  1. Java版本低于14" -ForegroundColor Yellow
    Write-Host "  2. JAVA_HOME环境变量未配置" -ForegroundColor Yellow
    Write-Host "  3. 缺少必要的模块" -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ✓ 打包完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 查找生成的文件
$distFiles = Get-ChildItem -Path "target\dist" -Recurse

if ($distFiles) {
    Write-Host "输出文件：" -ForegroundColor Yellow
    foreach ($file in $distFiles) {
        if ($file.Extension -eq '.exe' -or $file.Extension -eq '.app' -or $file.Extension -eq '.dmg') {
            Write-Host "  ✓ $($file.FullName)" -ForegroundColor Green
        }
    }
    Write-Host ""
    Write-Host "提示：" -ForegroundColor Cyan
    Write-Host "  - Windows: 直接运行 .exe 文件" -ForegroundColor White
    Write-Host "  - 无需安装Java环境" -ForegroundColor White
    Write-Host "  - 文件大小约100-150MB（包含JRE）" -ForegroundColor White
}

Write-Host ""
Write-Host "按任意键退出..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

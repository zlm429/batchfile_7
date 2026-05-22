# 创建测试数据的PowerShell脚本

$testDir = "D:\TestRename"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  创建测试数据" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 创建测试目录
if (Test-Path $testDir) {
    Write-Host "发现已存在的测试目录，正在清理..." -ForegroundColor Yellow
    Remove-Item $testDir -Recurse -Force
}

New-Item -ItemType Directory -Path $testDir | Out-Null
Write-Host "已创建测试目录: $testDir" -ForegroundColor Green

# 创建5个测试文件夹
Write-Host ""
Write-Host "正在创建测试文件夹..." -ForegroundColor Cyan

for ($i = 1; $i -le 5; $i++) {
    $folderName = "folder_{0:D3}" -f $i
    $folderPath = Join-Path $testDir $folderName
    New-Item -ItemType Directory -Path $folderPath | Out-Null
    
    # 在每个文件夹中创建测试文件
    New-Item -ItemType File -Path (Join-Path $folderPath "document.docx") | Out-Null
    New-Item -ItemType File -Path (Join-Path $folderPath "spreadsheet.xlsx") | Out-Null
    New-Item -ItemType File -Path (Join-Path $folderPath "image.jpg") | Out-Null
    
    Write-Host "  ✓ 已创建: $folderName (包含3个测试文件)" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  测试数据创建完成！" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "位置: $testDir" -ForegroundColor Yellow
Write-Host ""
Write-Host "下一步：" -ForegroundColor Cyan
Write-Host "1. 创建一个Excel文件，在第一列输入新的文件夹名称" -ForegroundColor White
Write-Host "2. 运行应用程序: .\run.ps1" -ForegroundColor White
Write-Host "3. 选择Excel文件和测试目录进行重命名测试" -ForegroundColor White
Write-Host ""

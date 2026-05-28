# 创建临时目录存放JavaFX模块
$javafxDir = "target\javafx-modules"
New-Item -ItemType Directory -Path $javafxDir -Force | Out-Null

# 复制所有JavaFX JAR文件到临时目录
$m2Repo = "C:\Users\Admin\.m2\repository\org\openjfx"

# 复制 javafx-controls
Copy-Item "$m2Repo\javafx-controls\17.0.2\*.jar" $javafxDir -Force

# 复制 javafx-fxml
Copy-Item "$m2Repo\javafx-fxml\17.0.2\*.jar" $javafxDir -Force

# 复制 javafx-base
Copy-Item "$m2Repo\javafx-base\17.0.2\*.jar" $javafxDir -Force

# 复制 javafx-graphics
Copy-Item "$m2Repo\javafx-graphics\17.0.2\*.jar" $javafxDir -Force

Write-Host "JavaFX模块已复制到: $javafxDir"
Get-ChildItem $javafxDir | Select-Object Name

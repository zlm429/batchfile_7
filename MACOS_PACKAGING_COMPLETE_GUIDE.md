# macOS 打包完整指南

## 📦 需要传输到 Mac 的文件清单

### ✅ 必需文件（必须传输）

```
batchfile_app/                    # 项目根目录
├── .mvn/                         # Maven Wrapper 配置
│   └── wrapper/
│       └── maven-wrapper.properties
├── src/                          # 源代码目录
│   ├── main/
│   │   ├── java/
│   │   │   └── com/rt/batchfile_app/
│   │   │       ├── BatchfileAppApplication.java
│   │   │       ├── RenameController.java
│   │   │       └── module-info.java
│   │   └── resources/
│   │       └── com/rt/batchfile_app/
│   │           └── hello-view.fxml
│   └── test/                     # 测试代码（可选）
├── mvnw                          # Maven Wrapper 脚本（Unix/Linux/macOS）
├── pom.xml                       # Maven 项目配置文件
└── .gitignore                    # Git 忽略文件（可选）
```

### ❌ 不需要传输的文件

```
target/                           # 编译输出目录（会在 Mac 上重新编译）
.idea/                            # IntelliJ IDEA 配置
*.iml                             # IDE 模块文件
.DS_Store                         # macOS 系统文件
Thumbs.db                         # Windows 缩略图缓存
*.log                             # 日志文件
*.tmp, *.bak                      # 临时文件
package.bat                       # Windows 批处理脚本
run.bat                           # Windows 启动脚本
create_javafx_modules.ps1         # PowerShell 脚本
create_test_data.ps1              # PowerShell 脚本
test-compile.ps1                  # PowerShell 脚本
tempfile_*.powershell             # 临时 PowerShell 文件
FIXED_PIPELINE.txt                # Gitee 配置草稿
GITEE_PIPELINE_CONFIG.txt         # Gitee 配置草稿
```

## 🚀 传输方法

### 方法1：使用 Git（推荐）⭐

**在 Windows 上：**
```powershell
cd F:\batchfile_app
git add .
git commit -m "准备 macOS 打包"
git push origin master
```

**在 macOS 上：**
```bash
git clone https://gitee.com/zeng-limin00/batchfile_app.git
cd batchfile_app
```

### 方法2：使用压缩文件

**在 Windows 上：**
1. 选中以下文件夹和文件：
   - `.mvn/`
   - `src/`
   - `mvnw`
   - `pom.xml`
   - `.gitignore`（可选）
2. 右键 → 发送到 → 压缩(zipped)文件夹
3. 命名为 `batchfile_app_mac.zip`
4. 通过 U盘/网盘/邮件 传输到 Mac

**在 macOS 上：**
```bash
unzip batchfile_app_mac.zip
cd batchfile_app
chmod +x mvnw  # 赋予执行权限
```

### 方法3：使用 rsync（局域网传输）

**在 macOS 上：**
```bash
rsync -avz --exclude 'target' --exclude '.idea' \
  user@windows-ip:/path/to/batchfile_app/ \
  ~/batchfile_app/
```

## 💻 macOS 打包步骤

### 前置条件

1. **安装 JDK 17**
   ```bash
   # 方法1：使用 Homebrew（推荐）
   brew install openjdk@17
   
   # 方法2：手动下载
   # 访问 https://adoptium.net/temurin/releases/?version=17
   # 下载 macOS ARM64 (Apple Silicon) 或 x64 (Intel) 版本
   ```

2. **验证 Java 安装**
   ```bash
   java -version
   # 应该显示：openjdk version "17.x.x"
   ```

3. **安装 JavaFX SDK**（如果 jpackage 需要）
   ```bash
   # 下载 JavaFX SDK
   curl -L https://download2.gluonhq.com/openjfx/17.0.2/openjfx-17.0.2_osx-aarch64_bin-sdk.zip -o javafx.zip
   unzip javafx.zip
   mv javafx-sdk-17.0.2 /usr/local/lib/javafx-sdk
   ```

### 开始打包

#### 步骤1：编译项目

```bash
cd ~/batchfile_app
chmod +x mvnw
./mvnw clean package -DskipTests
```

等待编译完成，会在 `target/` 目录生成 JAR 文件。

#### 步骤2：打包成 DMG（macOS 安装包）

```bash
# 基本打包命令
jpackage --input target \
         --name "批量文件夹重命名工具" \
         --main-jar batchfile_app-0.0.1-SNAPSHOT.jar \
         --main-class com.rt.batchfile_app.BatchfileAppApplication \
         --dest target/dist \
         --type dmg \
         --app-version 1.0.0 \
         --vendor RT \
         --java-options "--add-modules" \
         --java-options "javafx.controls,javafx.fxml"
```

**如果需要指定 JavaFX 模块路径：**
```bash
jpackage --input target \
         --name "批量文件夹重命名工具" \
         --main-jar batchfile_app-0.0.1-SNAPSHOT.jar \
         --main-class com.rt.batchfile_app.BatchfileAppApplication \
         --dest target/dist \
         --type dmg \
         --app-version 1.0.0 \
         --vendor RT \
         --module-path /usr/local/lib/javafx-sdk/lib \
         --add-modules javafx.controls,javafx.fxml
```

#### 步骤3：等待打包完成

打包过程可能需要 2-5 分钟，完成后会生成：
```
target/dist/批量文件夹重命名工具-1.0.0.dmg
```

### 验证安装包

```bash
# 挂载 DMG 文件
hdiutil attach target/dist/批量文件夹重命名工具-1.0.0.dmg

# 查看应用
ls /Volumes/批量文件夹重命名工具/

# 卸载 DMG
hdiutil detach /Volumes/批量文件夹重命名工具
```

## 📁 打包后的文件结构

成功打包后，DMG 文件包含：
```
批量文件夹重命名工具.app/
├── Contents/
│   ├── Info.plist
│   ├── MacOS/
│   │   └── 批量文件夹重命名工具    # 可执行文件
│   ├── Resources/
│   │   └── app/
│   │       └── batchfile_app-0.0.1-SNAPSHOT.jar
│   └── Runtime/                    # 内置 JRE
│       ├── bin/
│       ├── lib/
│       └── ...
```

## 🔧 常见问题解决

### 问题1：jpackage 找不到 JavaFX 模块

**错误信息：**
```
Error: Module javafx.controls not found
```

**解决方案：**
```bash
# 1. 下载 JavaFX SDK for macOS
curl -L https://download2.gluonhq.com/openjfx/17.0.2/openjfx-17.0.2_osx-aarch64_bin-sdk.zip -o javafx.zip
unzip javafx.zip

# 2. 使用 --module-path 参数
jpackage --module-path /path/to/javafx-sdk/lib \
         --add-modules javafx.controls,javafx.fxml \
         ...其他参数...
```

### 问题2：权限不足

**错误信息：**
```
Permission denied
```

**解决方案：**
```bash
chmod +x mvnw
sudo jpackage ...  # 或使用管理员权限
```

### 问题3：架构不匹配（Apple Silicon vs Intel）

**检查 Mac 架构：**
```bash
uname -m
# arm64 = Apple Silicon (M1/M2/M3)
# x86_64 = Intel
```

**下载对应的 JavaFX SDK：**
- Apple Silicon: `openjfx-17.0.2_osx-aarch64_bin-sdk.zip`
- Intel: `openjfx-17.0.2_osx-x64_bin-sdk.zip`

### 问题4：中文名称乱码

**解决方案：**
确保系统语言支持中文，或在打包时使用英文名称：
```bash
jpackage --name "BatchRenameTool" \
         ...其他参数...
```

## 📤 将 DMG 传回 Windows

打包完成后，可以通过以下方式传回 Windows：

1. **网盘上传**：百度网盘、阿里云盘、OneDrive
2. **U盘拷贝**：直接复制到 U盘
3. **局域网传输**：
   ```bash
   # 在 Mac 上启用文件共享
   scp target/dist/*.dmg user@windows-ip:/path/to/save/
   ```

## ✨ 快速打包脚本

创建 `package-macos.sh` 脚本自动化打包：

```bash
#!/bin/bash

echo "🚀 开始 macOS 打包..."

# 清理旧的构建
rm -rf target/dist

# 编译项目
echo "📦 编译项目..."
./mvnw clean package -DskipTests

if [ $? -ne 0 ]; then
    echo "❌ 编译失败！"
    exit 1
fi

# 打包成 DMG
echo "📦 打包 DMG..."
jpackage --input target \
         --name "批量文件夹重命名工具" \
         --main-jar batchfile_app-0.0.1-SNAPSHOT.jar \
         --main-class com.rt.batchfile_app.BatchfileAppApplication \
         --dest target/dist \
         --type dmg \
         --app-version 1.0.0 \
         --vendor RT \
         --java-options "--add-modules" \
         --java-options "javafx.controls,javafx.fxml"

if [ $? -eq 0 ]; then
    echo "✅ 打包成功！"
    echo "📁 DMG 文件位置: target/dist/批量文件夹重命名工具-1.0.0.dmg"
    ls -lh target/dist/*.dmg
else
    echo "❌ 打包失败！"
    exit 1
fi
```

**使用方法：**
```bash
chmod +x package-macos.sh
./package-macos.sh
```

## 📋 检查清单

在开始打包前，请确认：

- [ ] 已安装 JDK 17
- [ ] Java 版本正确（`java -version` 显示 17.x.x）
- [ ] 项目文件完整传输（`.mvn/`, `src/`, `pom.xml`, `mvnw`）
- [ ] `mvnw` 有执行权限（`chmod +x mvnw`）
- [ ] （可选）已下载 JavaFX SDK for macOS
- [ ] 网络连接正常（首次编译需要下载依赖）

## 🎯 最简流程

如果您只想快速打包，执行以下命令即可：

```bash
# 1. 克隆代码
git clone https://gitee.com/zeng-limin00/batchfile_app.git
cd batchfile_app

# 2. 赋予权限
chmod +x mvnw

# 3. 编译并打包
./mvnw clean package -DskipTests
jpackage --input target \
         --name "BatchRenameTool" \
         --main-jar batchfile_app-0.0.1-SNAPSHOT.jar \
         --main-class com.rt.batchfile_app.BatchfileAppApplication \
         --dest target/dist \
         --type dmg \
         --app-version 1.0.0 \
         --vendor RT \
         --java-options "--add-modules" \
         --java-options "javafx.controls,javafx.fxml"

# 4. 完成！
ls -lh target/dist/*.dmg
```

---

**祝您打包顺利！** 🎉

如有问题，请查看错误信息或联系技术支持。

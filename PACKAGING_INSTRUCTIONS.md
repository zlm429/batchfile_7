# 批量文件夹重命名工具 - 使用说明

## 📦 打包说明

由于jpackage在Windows上存在bug（会导致无限递归目录），我们采用更可靠的启动方式。

## 🚀 使用方法

### 方法1：直接运行JAR（推荐）

**前提条件**：需要安装Java 17或更高版本

1. **检查Java是否安装**
   ```powershell
   java -version
   ```

2. **如果没有安装Java**
   - 下载地址：https://adoptium.net/
   - 下载并安装 JDK 17 或更高版本

3. **运行程序**
   - 双击 `target\启动程序.ps1` 
   - 或者在PowerShell中执行：
     ```powershell
     cd F:\batchfile_app\target
     .\启动程序.ps1
     ```

4. **或者直接命令行运行**
   ```powershell
   cd F:\batchfile_app\target
   java --add-modules javafx.controls,javafx.fxml -jar batchfile_app-0.0.1-SNAPSHOT.jar
   ```

### 方法2：使用已损坏的exe（不推荐）

之前打包的exe文件位于 `target\dist\BatchRenameTool\BatchRenameTool.exe`，但由于jpackage bug导致配置文件损坏，**无法正常运行**。

## ⚠️ 重要提示

1. **必须安装Java环境**
   - 本程序需要Java 17或更高版本
   - JavaFX模块已通过Maven依赖包含

2. **不要使用exe版本**
   - `target\dist\BatchRenameTool` 目录是由于jpackage bug产生的
   - 该目录结构已被破坏（无限递归）
   - 建议删除该目录以节省空间

3. **推荐使用启动脚本**
   - 使用 `target\启动程序.ps1` 启动
   - 脚本会自动检查Java环境
   - 提供友好的错误提示

## 🔧 如果需要独立exe（无需Java）

如果您需要一个不需要安装Java就能运行的exe文件，有以下几种方案：

### 方案1：使用GitHub Actions自动打包（推荐）
项目已配置好 `.github/workflows/build.yml`，推送到GitHub后会自动打包成：
- Windows: .exe
- macOS: .dmg
- Linux: .deb/.rpm

### 方案2：在macOS电脑上打包
如果需要在没有Java的Mac上运行，必须在macOS电脑上执行：
```bash
mvn clean package
jpackage --input target \
         --name "批量文件夹重命名工具" \
         --main-jar batchfile_app-0.0.1-SNAPSHOT.jar \
         --main-class com.rt.batchfile_app.BatchfileAppApplication \
         --dest target/dist \
         --type dmg \
         --module-path /path/to/javafx-sdk/lib \
         --add-modules javafx.controls,javafx.fxml
```

### 方案3：使用Launch4j（Windows专用）
可以使用Launch4j将JAR包装成exe，但仍需要JRE。

## 📝 总结

**当前最可靠的使用方式**：
1. 安装Java 17+
2. 运行 `target\启动程序.ps1`
3. 享受批量重命名功能！

---

如有问题，请查看项目根目录的README.md获取更多帮助。

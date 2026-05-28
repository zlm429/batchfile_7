# macOS 打包必需文件清单（精简版）

## 📦 必须传输到 Mac 的文件

### 核心文件（5个）

```
✅ .mvn/                    # Maven Wrapper 配置目录
✅ src/                     # 所有源代码
✅ mvnw                     # Maven 启动脚本（Unix版本）
✅ pom.xml                  # Maven 项目配置
✅ .gitignore               # Git 忽略规则（可选）
```

### 总大小：约 100-200 KB（不含依赖）

---

## 🚫 不需要传输的文件

```
❌ target/                  # 编译输出（Mac上会重新生成）
❌ .idea/                   # IDE 配置
❌ *.bat                    # Windows 批处理脚本
❌ *.ps1                    # PowerShell 脚本
❌ *.md                     # 文档文件（可选传输）
❌ *.txt                    # 临时文本文件
❌ *.jar                    # 编译产物
```

---

## 📤 推荐传输方法

### 方法1：Git（最简单）⭐

**Windows:**
```powershell
cd F:\batchfile_app
git add .
git commit -m "准备macOS打包"
git push
```

**Mac:**
```bash
git clone https://gitee.com/zeng-limin00/batchfile_app.git
cd batchfile_app
```

### 方法2：压缩包

**Windows:**
1. 选中：`.mvn/`, `src/`, `mvnw`, `pom.xml`
2. 压缩成 `batchfile_app.zip`
3. 传到 Mac

**Mac:**
```bash
unzip batchfile_app.zip
cd batchfile_app
chmod +x mvnw
```

---

## 💻 Mac 上执行命令

```bash
# 1. 安装 Java 17
brew install openjdk@17

# 2. 编译项目
./mvnw clean package -DskipTests

# 3. 打包成 DMG
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

## ⚠️ 注意事项

1. **mvnw 必须有执行权限**
   ```bash
   chmod +x mvnw
   ```

2. **首次编译需要网络**（下载依赖）

3. **如果 jpackage 找不到 JavaFX**，需要下载 JavaFX SDK for macOS

4. **建议使用英文名称**避免中文路径问题：
   ```bash
   --name "BatchRenameTool"  # 而不是 "批量文件夹重命名工具"
   ```

---

## 📋 快速检查清单

传输前确认：
- [ ] `.mvn/` 目录存在
- [ ] `src/` 目录完整
- [ ] `mvnw` 文件存在
- [ ] `pom.xml` 文件存在
- [ ] 已推送到 Git 或已压缩

打包前确认：
- [ ] Java 17 已安装
- [ ] `java -version` 显示 17.x.x
- [ ] `mvnw` 有执行权限
- [ ] 网络连接正常

---

**就这么简单！** 🎉

# 命名规则更新说明

## 📅 更新时间
2026-05-22

## 🔄 修改内容

### 1. 文件夹命名规则
**之前**：Excel 4列用空格连接  
**现在**：Excel 4列用 `-`（短横线）连接

**示例**：
- Excel数据：A列="ABC123", B列="产品A", C列="规格1", D列="版本2"
- 之前命名：`ABC123 产品A 规格1 版本2`
- 现在命名：`ABC123-产品A-规格1-版本2`

### 2. 文件命名规则
**之前**：使用完整的文件夹名称  
**现在**：只使用料号（第一个 `-` 前面的部分）

**示例**：
- 文件夹名称：`ABC123-产品A-规格1-版本2`
- 之前文件命名：`ABC123-产品A-规格1-版本2.jpg`
- 现在文件命名：`ABC123.jpg`

## 💡 使用场景

这个修改适用于以下场景：
- 文件夹需要完整的信息描述（用 `-` 分隔各字段）
- 文件只需要料号作为标识（简洁明了）

## 📝 代码变更

### 修改的文件
- `src/main/java/com/rt/batchfile_app/RenameController.java`

### 主要改动
1. **第216行**：将空格 `" "` 改为短横线 `"-"`
   ```java
   nameBuilder.append("-"); // 用短横线连接各列
   ```

2. **新增方法**：`extractMaterialCode(String folderName)`
   - 提取第一个 `-` 前面的部分作为料号
   - 如果没有 `-`，则返回整个名称

3. **第325-327行**：在重命名文件时调用新方法
   ```java
   String folderName = folder.getName();
   String materialCode = extractMaterialCode(folderName);
   renameFilesInFolder(folder, materialCode);
   ```

## ✅ 测试状态

- ✅ 编译成功
- ✅ 程序正常启动
- ⏳ 等待用户实际测试验证

## 🚀 如何运行

```powershell
cd F:\batchfile_app
.\mvnw.cmd javafx:run
```

## 📌 注意事项

1. **文件夹命名**：确保Excel中的4列数据都有意义，会用 `-` 连接
2. **文件命名**：如果文件夹名中没有 `-`，则使用整个文件夹名作为料号
3. **空文件夹**：会被自动跳过，不会报错

---

如有疑问或需要进一步调整，请随时告知！

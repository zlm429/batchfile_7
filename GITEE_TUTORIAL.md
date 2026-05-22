# 🚀 Gitee（码云）自动打包教程

##  为什么选择Gitee？

✅ **中文界面** - 全中文，好理解  
✅ **访问快速** - 国内服务器，不卡顿  
✅ **微信登录** - 支持微信/QQ登录  
✅ **免费额度** - 每月500分钟构建时间  
✅ **自动打包** - 推送代码自动打包三平台  

---

## 📋 完整操作步骤

### 第一步：注册Gitee账号

1. **访问** https://gitee.com
2. **注册账号**
   - 点击"注册"
   - 可以用**手机号**或**微信**注册
   - 完成验证

---

### 第二步：创建仓库

1. **登录Gitee后**
   - 点击右上角 **"+"** 号
   - 选择 **"新建仓库"**

2. **填写信息**
   ```
   仓库名称: batchfile_app
   仓库介绍: 批量文件夹重命名工具
   是否开源: 公开
   初始化仓库: 不勾选（我们已有代码）
   ```

3. **点击"创建"**

4. **复制仓库地址**
   - 创建后，页面显示仓库地址
   - 类似：`https://gitee.com/你的用户名/batchfile_app.git`
   - 复制这个地址

---

### 第三步：推送代码到Gitee

打开PowerShell，在项目目录下执行：

```powershell
# 1. 进入项目目录
cd F:\batchfile_app

# 2. 初始化Git（如果还没初始化）
git init

# 3. 添加所有文件
git add .

# 4. 提交代码
git commit -m "第一次提交：批量文件夹重命名工具"

# 5. 关联Gitee仓库（替换成你的仓库地址）
git remote add origin https://gitee.com/你的用户名/batchfile_app.git

# 6. 推送代码
git push -u origin master
```

**注意**：
- 第一次推送会要求输入Gitee账号和密码
- Gitee的默认分支是 `master`（不是main）

---

### 第四步：启用Gitee Go（自动打包）

1. **进入仓库页面**
   ```
   https://gitee.com/你的用户名/batchfile_app
   ```

2. **点击"服务" → "Gitee Go"**
   - 在仓库左侧菜单找到 **"服务"**
   - 点击 **"Gitee Go"**

3. **启用流水线**
   - 点击 **"新建流水线"**
   - 选择 **"自定义流水线"**
   - 上传配置文件（项目已包含 `.gitee/build.yml`）

4. **或者手动创建**
   - 点击"新建流水线"
   - 复制 `.gitee/build.yml` 的内容
   - 粘贴到配置编辑器中
   - 保存并运行

---

### 第五步：查看打包结果

1. **查看构建状态**
   - 点击 **"服务" → "Gitee Go"**
   - 查看流水线运行状态
   - 等待3-5分钟

2. **下载打包文件**
   - 构建成功后，点击运行记录
   - 找到 **"Artifacts"** 或 **"产物"**
   - 下载：
     - `windows-app` → Windows版本
     - `macos-app` → macOS版本
     - `linux-app` → Linux版本

---

##  可视化流程

```
本地电脑          Gitee仓库           Gitee Go          结果
┌────────┐      ┌──────────┐      ┌──────────     ┌──────────┐
│        │ push │          │ 触发 │          │     │          │
│  代码  │────→│  仓库    │────→│ 打包机器 │────→│ .exe     │
│        │      │          │      │          │     │ .dmg     │
└────────┘      └──────────┘      └──────────     │ .deb     │
                                                     └────┬─────┘
                                                          │
                                                    你下载 ←┘
```

---

##  超简单三步法

如果你觉得上面太复杂，只记住这三步：

### 1️⃣ 创建Gitee仓库
- 登录 https://gitee.com
- 点"+" → 新建仓库 → 创建

### 2️⃣ 推送代码
```powershell
cd F:\batchfile_app
git init
git add .
git commit -m "提交代码"
git remote add origin https://gitee.com/你的用户名/batchfile_app.git
git push -u origin master
```

### 3️⃣ 配置自动打包
- 进入仓库 → 服务 → Gitee Go
- 新建流水线 → 使用 `.gitee/build.yml`
- 等待打包完成 → 下载结果

---

## ️ 常见问题

### Q1: 推送时报错 "Repository not found"
**解决**：检查仓库地址是否正确
```powershell
# 查看远程仓库
git remote -v

# 如果错了，重新设置
git remote remove origin
git remote add origin https://gitee.com/你的用户名/batchfile_app.git
```

### Q2: Gitee Go在哪里找？
**解决**：
- 进入仓库页面
- 左侧菜单找 **"服务"**
- 点击 **"Gitee Go"**

### Q3: 构建失败了怎么办？
**解决**：
1. 点击失败的流水线
2. 查看详细日志
3. 通常是代码问题，修复后重新推送

### Q4: 免费额度够用吗？
**解决**：
- 每月500分钟，完全够用
- 每次构建约5分钟
- 可以构建100次/月

---

##  对比GitHub和Gitee

| 特性 | GitHub | Gitee |
|------|--------|-------|
| 访问速度 | 慢（国外） | 快（国内）✅ |
| 界面语言 | 英文 | 中文✅ |
| 登录方式 | 邮箱 | 微信/QQ✅ |
| 免费额度 | 2000分钟/月 | 500分钟/月 |
| 自动打包 | GitHub Actions | Gitee Go |
| 配置方式 | `.github/workflows/` | `.gitee/` |

**建议**：国内用户优先使用Gitee！

---

##  快速上手检查清单

- [ ] 注册Gitee账号
- [ ] 创建仓库 `batchfile_app`
- [ ] 复制仓库地址
- [ ] 执行 `git push` 推送代码
- [ ] 进入仓库 → 服务 → Gitee Go
- [ ] 新建流水线（使用 `.gitee/build.yml`）
- [ ] 等待构建完成
- [ ] 下载打包文件

---

##  我的建议

### 第一次使用
1. 先注册Gitee账号（1分钟）
2. 创建仓库（1分钟）
3. 推送代码（3分钟）
4. 配置Gitee Go（2分钟）
5. 等待打包（5分钟）

**总共不超过15分钟！**

### 以后每次更新
只需要：
1. 修改代码
2. `git push`
3. 等待自动打包
4. 下载新版本

---

##  需要帮助？

如果遇到问题：

1. **查看错误提示** - Gitee会显示详细错误
2. **检查配置文件** - 确认 `.gitee/build.yml` 存在
3. **联系我** - 告诉我卡在哪一步

**加油！Gitee比GitHub简单多了，全中文界面，很好用的！**

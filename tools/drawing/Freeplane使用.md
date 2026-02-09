
## 安装

```bash
sudo apt-get install freeplane
```

## 快捷键

| 快捷键 | 说明                              |
|--------|-----------------------------------|
| F2     | 进入编辑模式                      |
| F3     | 进入细节编辑模式，Ctrl+Enter 换行 |


## 附录

### 解决图标显示问题

- 确认窗口类，执行`xprop`之后，点击freeplane 窗口.

  命令会输出两条字符串，分别为 实例名、窗口类名.

  ```bash
  $ xprop WM_CLASS
  WM_CLASS(STRING) = "org-knopflerfish-framework-BundleThread", "org-knopflerfish-framework-BundleThread"
  ```

- `freeplane.desktop` 中添加

  ```
  StartupWMClass=org-knopflerfish-framework-BundleThread
  ```

- 重启应用即可



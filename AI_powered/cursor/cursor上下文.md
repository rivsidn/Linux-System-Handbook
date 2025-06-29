
## 上下文

### 代码库索引


支持同步修改多个文件.

所有添加到工作区中的codebases 都会被自动建立索引.

* 如何查看文件索引
    分别打开检查.
* 如何删除所有代码库
    可以通过删除账户，清空所有索引.
* 项目索引的限制
    高级用户能够索引50000个文件；商业版用户能够索引250000个文件.


### Rules

* 项目Rules
* 用户Rules
* 记忆Rules

#### 项目Rules

引用规则时，内核会包含在模型上下文的开头，为AI提供一致性指导.


项目规则位于`.cursor/rules`下，可以使用文件路径、手动调用、相关性来管理规则添加。

使用项目规则来:

* 对代码库特定领域进行编码
* 自动化特定项目的工作流和模板
* 标准化风格和项目决策

可以在mdc 文件中 `@filename` 引用其他文件。

规则嵌套(目录下创建`.cursor/rules`):

* 目录中的文件被引用时自动添加
* 仍然可以在上下文选择器和代理可访问规则列表中使用
* 在相近代码位置提供特定领域代码

规则创建

规则生成

`/Generate Cursor Rules` 命令生成`Rules`。

会自动根据当前会话生成`Rules`并保存，之后可以复用.

最优实践

好的Rules应该聚焦、可以操作、有范围.

* 规则应该精简，500行以内
* 将一个大的概念分割成多个、可组合的规则
* 提供明确的示例和引用文件
* 避免模糊的描述，像写内部文档一样写规则
* 需要重复prompt 的时候通过规则来实现

#### 用户Rules

* 设置回复语言和语调
* 添加个人风格的偏好

#### 内存Rules

内存规则仅在`git`仓库范围内可见，可以通过查看、删除内存规则.

可以通过`@filename` 引用其他文件或者规则.

规则仅仅在`Agent`、`Cmd-K`模式下有效.


### 上下文管理

#### 状态

* 压缩
* 超级压缩
* 未包含

### 模型上下文协议

使用`MCP`给`Cursor`连接额外的工具、数据源.

`MCP`协议是一种开源的协议，支持多种语言.

| 传输类型        |
|-----------------|
| stdio           |
| SSE             |
| Streamable HTTP |



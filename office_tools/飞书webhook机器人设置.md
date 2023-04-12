## 使用场景

当实时监控设备时，在设备异常时候，希望能够获取实时通知。

飞书`webhook` 机器人拉近群聊的时候，可以获取到一个网址，向该网址中发送数据，可以在飞书群中显示，实现实时通知消息的目的。



## 使用

### 基础使用

* 创建群聊，`windows` 中将`webhook` 机器人拉入群聊，此时可以获取到一个网址

* 使用`curl` 发送数据到群聊

  ```bash
  curl -X POST -H "Content-Type: application/json" -d '{"msg_type":"text","content":{"text":"request example"}}' https://open.feishu.cn/open-apis/bot/v2/hook/xxxxxxxxxxxxxxxxx
  ```

  此处的`https://open.feishu.cn/open-apis/bot/v2/hook/xxxxxxxxxxxxxxxxx` 地址即是创建机器人时得到的网址。

### 安全设置

/\*TODO\*/

### 发送富文本消息

/\*TODO\*/



## 附录

### 参考资料

* [自定义机器人指南](https://open.feishu.cn/document/uktmuktmuktm/uctm5yjl3eto24ynxkjn)

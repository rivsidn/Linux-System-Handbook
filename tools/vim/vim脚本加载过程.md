主要用于解析`vim`启动过程中，脚本文件的加载过程。



## 创建调用关系图

### 获取启动日志文件

```bash
# 获取日志文件
vim -V2
```

### 调用关系图生成

```bash
python3 vim_starup.py starup.log
```



## 启动过程解析







## 附录

### 调用关系图生成脚本

```python
#!/usr/bin/env python3

import graphviz
import argparse

def parse_vim_log(file_path):
    """解析Vim启动日志文件，提取脚本加载依赖关系和行号。"""
    edges = []
    stack = []
    current_file = None
    
    with open(file_path, 'r') as file:
        for line in file:
            line = line.strip()
            if line.startswith('sourcing'):
                # 提取被加载的脚本路径
                path = line.split(' ')[-1].strip('"')
                # 将当前脚本压入栈
                stack.append(path)
                # 添加没有parent的边
                edges.append(("", path, 0))
            elif line.startswith('line'):
                # 提取行号
                parts = line.split(':')
                line_number = int(parts[0].split(' ')[-1])
                path = parts[1].strip().split(' ')[-1].strip('"')
                if stack:
                    # 当前脚本是上一个脚本的子节点
                    parent_path = stack[-1]
                    edges.append((parent_path, path, line_number))

                    # 调试
                    print(parent_path, path, line_number)

                stack.append(path);
            elif line.startswith('finished sourcing'):
                # 从栈中弹出已完成的脚本
                path = line.split(' ')[-1].strip('"')
                if stack and stack[-1] == path:
                    stack.pop()
    return edges


def create_vim_startup_graph_from_log(log_file_path):
    # 解析日志文件获取依赖关系
    edges = parse_vim_log(log_file_path)
    
    # 创建一个有向图
    dot = graphviz.Digraph(comment='Vim Startup Script Loading Graph')
    dot.attr(rankdir='LR')
    
    # 设置节点样式
    dot.attr('node', shape='box', style='rounded')
    
    # 添加节点和边
    for source, target, line_number in edges:
        # 使用完整路径作为节点标签
        source_label = source
        target_label = target
        
        if len(source_label) == 0:
            dot.node(target, target_label)
            continue

        dot.node(source, source_label)
        dot.node(target, target_label)
        # 在边上添加行号信息
        dot.edge(source, target, label=f"line {line_number}")
    
    # 保存图形
    dot.render('vim_startup_graph', format='png', cleanup=True)


def main():
    parser = argparse.ArgumentParser(description='Generate a Vim startup script loading graph.')
    parser.add_argument('log_file', type=str, help='Path to the Vim startup log file')
    args = parser.parse_args()

    create_vim_startup_graph_from_log(args.log_file)


if __name__ == '__main__':
    main()

```














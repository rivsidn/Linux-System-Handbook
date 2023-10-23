

* 分析kernel history 的git 组织？



## TODO

* 梳理git的重要元素

* 如何查看git的日志

* 如何查看`merge` 时候的`--graph`日志输出

* 如何理解本地的`git remote show` 输出

  ```bash
  I_rivsidn@rivsidn:~/linux-kernel/linux$ git remote show origin
  * remote origin
    Fetch URL: https://github.com/torvalds/linux.git
    Push  URL: https://github.com/torvalds/linux.git
    HEAD branch: master
    Remote branch:
      master tracked
    Local branch configured for 'git pull':
      master merges with remote master
    Local ref configured for 'git push':
      master pushes to master (up to date)
  
  I_rivsidn@rivsidn:~/linux-kernel/linux$ git remote show github
  * remote github
    Fetch URL: https://github.com/rivsidn/linux.git
    Push  URL: https://github.com/rivsidn/linux.git
    HEAD branch: master
    Remote branches:
      master             tracked
      v2.6.12-annotation tracked
    Local branch configured for 'git pull':
      v2.6.12-annotation merges with remote v2.6.12-annotation
    Local refs configured for 'git push':
      master             pushes to master             (fast-forwardable)
      v2.6.12-annotation pushes to v2.6.12-annotation (up to date)
  ```

* 提交分支到github之后，显示的PR是什么意思？

* [个性化你的 Git Log 的输出格式](https://ruby-china.org/topics/939)



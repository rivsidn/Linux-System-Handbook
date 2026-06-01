


先总览提交历史：

:Git log --oneline --decorate --graph main..HEAD

如果你想按“完整差异”检查整个分支：

:Git difftool main...HEAD



• 可以，但要先说清楚一件事：

  fugitive 没有“PR 视图”这个概念，它本质上是把 Git 对象、提交、分支范围搬到 Vim 里操作。
  所以 review 一个 PR，实际做法是：把这个 PR 当成“一个分支相对基线分支的一组提交”来查看。

  假设：

  - 你已经把 PR 对应分支 checkout 到本地
  - 目标分支是 origin/main

  那这 3 个需求都能做。

  推荐工作流

  - 先看这次 PR 包含哪些提交
  - 再挑某个提交看它改了哪些文件
  - 再进入某个文件看具体 diff 内容

  1. 查看 PR 里有哪些提交

  最直接：

  :Git log --oneline --decorate --reverse origin/main..HEAD

  说明：

  - origin/main..HEAD：表示“当前分支相对 origin/main 多出来的提交”
  - --reverse：按从旧到新显示，更符合看 PR 的顺序
  - --decorate：会把分支、HEAD 等标出来

  如果你想看图形化一点：

  :Git log --graph --oneline --decorate origin/main..HEAD

  如果你只是想快速扫一眼，第一条已经够用了。

  2. 单独看某次提交改了哪些文件

  假设某个提交是 abc1234，用：

  :Git show --name-status --stat abc1234

  这个命令很适合 review，原因是它同时给你：

  - 改了哪些文件
  - 文件是 A/M/D/R 哪种变化
  - 每个文件增删了多少行

  如果你只想看文件列表，不看 patch：

  :Git show --name-only --format=fuller abc1234

  如果你还想顺便看提交说明和作者信息，show 本身就会带出来。

  3. 查看某个文件具体改了哪些内容

  还是基于提交 abc1234。

  看整个提交的 patch：

  :Git show abc1234

  只看这个提交里某个文件的 patch：

  :Git show abc1234 -- path/to/file

  这通常已经能满足“文件改了什么”的需求。

  如果你想用 Vim 的左右对比方式看某个文件，而不是只看 patch，可以这样：

  先打开工作区里的这个文件，然后执行：

  :Gvdiffsplit abc1234

  作用是：

  - 当前文件是你工作区版本
  - 另一边是 abc1234 这个提交里的版本
  - 用 vimdiff 左右对比

  这个方式在 review 复杂逻辑时，比只看 show 更清楚。

  一个更顺手的 PR review 流程

  如果我是用 fugitive review 多提交 PR，我会这样走：

  - :Git log --oneline --reverse origin/main..HEAD
      - 先拿到 commit 列表
  - 复制或记住一个提交 SHA
  - :Git show --name-status --stat <sha>
      - 看这次提交碰了哪些文件
  - :Git show <sha> -- path/to/file
      - 看单文件 patch
  - 如果这个文件逻辑复杂，打开该文件后再用：
      - :Gvdiffsplit <sha>

  这样比一上来直接看整个分支 diff 更稳，因为你是按提交粒度审的。

  如果你还想看“整个 PR 总共改了什么文件”

  这不是你刚才的 3 个点，但实际 review 很常用：

  :Git diff --name-status origin/main...HEAD

  或者直接看整个 PR 总 patch：

  :Git diff origin/main...HEAD

  这里我建议用 ...：

  - origin/main...HEAD 基于 merge-base，看的是这个分支真正引入的改动
  - 做 PR review 时通常比 .. 更接近平台上的 diff 视角

  但“看提交列表”还是建议用：

  origin/main..HEAD

  因为你要的是“多出来哪些提交”。

  结论

  你要的 3 件事，对应就是：

  - 看提交列表
    :Git log --oneline --decorate --reverse origin/main..HEAD
  - 看某次提交改了哪些文件
    :Git show --name-status --stat <sha>
  - 看文件具体改了什么
    :Git show <sha> -- path/to/file
    或者打开文件后 :Gvdiffsplit <sha>

  如果你愿意，我下一步可以直接给你一套“专门用于 PR review 的 fugitive 快捷键配置”，比如：

  - <leader>gl 看 PR 提交列表
  - <leader>gs 看当前提交改动
  - <leader>gd 对当前文件做 commit diff

  这样你就不用每次手敲命令了。



| 命令 | 说明 |
|------|------|




## 附录

### 官方README


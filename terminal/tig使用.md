
  m   main view，提交列表
  d   diff view，改动详情
  l   log view，提交日志详情
  t   tree view，目录树
  f   blob view，文件内容
  b   blame view
  s   status view
  c   stage view

常用快捷键

在 tig 里常见操作类似 vim：

j / ↓     向下移动
k / ↑     向上移动
Enter     打开当前选中的 commit / 文件 / diff
q         退出当前视图
Q         直接退出 tig
/         搜索
n         下一个搜索结果
N         上一个搜索结果
h         帮助

在提交历史里：

Enter     查看 commit 详情
d         查看 diff 视图
t         查看文件树

在 tig status 里：

u         暂存 / 取消暂存文件
!         丢弃修改，谨慎使用
C         提交，通常会调用 git commit

不同版本或配置下快捷键可能略有差异，可以在 tig 内按 h 查看帮助。

## 视图

| 视图   | 说明                       |
|--------|----------------------------|
| main   | 主视图，执行tig 进入的视图 |
| log    | 日志视图                   |
| reflog |                            |
| diff
| tree
| blob
| blame
| refs
| status
| stage
| stash
| grep
| pager
| help

## 快捷键

View Switching(视图切换)
    Key   Action

    m     Switch to main view.
          切换到main视图

    d     Switch to diff view.
          切换到diff视图

    l     Switch to log view.

    p     Switch to pager view.

    t     Switch to (directory) tree
          view.

    f     Switch to (file) blob view.

    g     Switch to grep view.

    b     Switch to blame view.

    r     Switch to refs view.
          引用视图

    y     Switch to stash view.

    h     Switch to help view

    s     Switch to status view

    c     Switch to stage view

View Manipulation
    Key     Action

    q       Close view, if multiple views
            are open it will jump back to
            the previous view in the view
            stack. If it is the last open
            view it will quit. Use Q to
            quit all views at once.

    Enter   This key is "context
            sensitive" depending on what
            view you are currently in.
            When in log view on a commit
            line or in the main view,
            split the view and show the
            commit diff. In the diff view
            pressing Enter will simply
            scroll the view one line down.

    Tab     Switch to next view.

    R       Reload and refresh the current
            view.

    O       Maximize the current view to
            fill the whole display.

    Up      This key is "context
            sensitive" and will move the
            cursor one line up. However,
            if you opened a split view it
            will change the cursor to
            point to the previous commit
            in the parent view and update
            the child view to display it.
            If you prefer this key to move
            the cursor or scroll within
            the diff view instead, use
            bind diff <Up> move-up or bind
            diff <Up> scroll-line-up,
            respectively.

    Down    Similar to Up but will move
            down.

    ,       Move to parent. In the tree
            view, this means switch to the
            parent directory. In the blame
            view it will load blame for
            the parent commit. For merges
            the parent is queried.

View Specific Actions
    Key   Action

    u     Update status of file. In the
          status view, this allows you
          to add an untracked file or
          stage changes to a file for
          next commit (similar to
          running git-add <filename>).
          In the stage view, when
          pressing this on a diff chunk
          line stages only that chunk
          for next commit, when not on a
          diff chunk line all changes in
          the displayed diff are staged.

    M     Resolve unmerged file by
          launching git-mergetool(1).
          Note, to work correctly this
          might require some initial
          configuration of your
          preferred merge tool. See the
          manpage of git-mergetool(1).

    !     Checkout file with unstaged
          changes. This will reset the
          file to contain the content it
          had at last commit.

    1     Stage single diff line.

    @     Move to next chunk in the
          stage view.

    ]     Increase the diff context.

    [     Decrease the diff context.

Cursor Navigation
    Key             Action

    k               Move cursor one line up.

    j               Move cursor one line down.

    PgUp, -         Move cursor one page up.

    PgDown, Space   Move cursor one page down.

    Home            Jump to first line.

    End             Jump to last line.

Scrolling
    Key          Action

    Insert       Scroll view one line up.

    Delete       Scroll view one line down.

    ScrollBack   Scroll view one page up.

    ScrollFwd    Scroll view one page down.

    Left         Scroll view one column left.

    Right        Scroll view one column right.

    |            Scroll view to the first
                 column.

Searching
    Key   Action

    /     Search the view. Opens a
          prompt for entering search
          regexp to use.

    ?     Search backwards in the view.
          Also prompts for regexp.

    n     Find next match for the
          current search regexp.

    N     Find previous match for the
          current search regexp.

    The format for patterns is either POSIX.2 “extended” REs or PCRE / PCRE2 if Tig was
    compiled with PCRE / PCRE2 support (check with tig -v). See the manpage of
    re_format(7) or pcrepattern(3) / pcre2pattern(3).

    Case sensitivity can be controlled with variable ignore-case.

Misc
    Key     Action

    Q       Quit.

    <C-L>   Redraw screen.

    z       Stop all background loading.
            This can be useful if you use
            Tig in a repository with a
            long history without limiting
            the revision log.

    v       Show version.

    o       Open option menu

    #       Toggle line numbers on/off.

    D       Toggle date display
            on/off/relative/relative-compact/custom

    A       Toggle author display
            on/off/abbreviated/email/email user
            name.

    G       Toggle revision graph visualization
            on/off.

    ~       Toggle (line) graphics mode

    F       Toggle reference display on/off (tag
            and branch names).

    W       Toggle ignoring whitespace on/off for
            diffs

    X       Toggle commit ID display on/off

    %       Toggle file filtering in order to see
            the full diff instead of only the diff
            concerning the currently selected file.

    ^       Toggle revision filtering in the main
            view.

    $       Toggle highlighting of commit title
            overflow.

    H       Go to the HEAD commit.

    :       Open prompt. This allows you to specify
            what command to run and also to jump to
            a specific line, e.g. :23

    e       Open file in editor.

Prompt
    Key                      Action

    :<number>                Jump to the specific line
                             number, e.g. :80.

    :<sha>                   Jump to a specific commit,
                             e.g. :2f12bcc.

    :<x>                     Execute the corresponding key
                             binding, e.g. :q.

    :!<command>              Execute a system command in a
                             pager, e.g. :!git log -p.

    :<action>                Execute a Tig command, e.g.
                             :edit.

    :goto <rev>              Jump to a specific revision,
                             e.g. :goto %(commit)^2 to goto
                             the current commit’s 2nd
                             parent or :goto some/branch to
                             goto the commit denoting the
                             branch some/branch.

    :save-display <file>     Save current display to
                             <file>.

    :save-options <file>     Save current options to
                             <file>.

    :save-view <file>        Save view info to <file> (for
                             testing purposes).

    :script <file>           Execute commands from <file>.

    :exec <flags><args...>   Execute command using <args>
                             with external user-defined
                             command option flags defined
                             in <flags>.

    :echo <args...>          Display text in the status
                             bar.

External Commands
    For more custom needs, external commands provide a way to easily execute a script or
    program. They are bound to keys and use information from the current browsing state,
    such as the current commit ID. Tig comes with the following built-in external
    commands:
    Keymap    Key   Action

    main      C     git cherry-pick
                    %(commit)

    status    C     git commit

    generic   G     git gc

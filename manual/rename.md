```
RENAME(1)                             User Commands                            RENAME(1)

NAME
       rename - rename files
                文件重命名

SYNOPSIS
       rename [options] expression replacement file...
       可以同时添加多个file，所以支持批量修改

DESCRIPTION
       rename  will  rename  the  specified  files  by replacing the first occurrence of
       expression in their name by replacement.
       文件重命名，名称中表达式第一次出现的位置替换成replacement.

OPTIONS
       -s, --symlink
              Do not rename a symlink but its target.
	      不是重命名链接，而是目标文件本身.

       -v, --verbose
              Show which files where renamed, if any.
	      显示重命名的文件

       -n, --no-act
              Do not make any changes.
	      不做任何修改

       -o, --no-overwrite
              Do not overwrite existing files.
	      不要覆盖已经存在的文件

       -V, --version
              Display version information and exit.
	      显示版本信息然后退出

       -h, --help
              Display help text and exit.
	      显示帮助信息然后退出

EXAMPLES
       Given the files foo1, ..., foo9, foo10, ..., foo278, the commands

              rename foo foo00 foo?
              rename foo foo0 foo??

       will turn them into foo001, ..., foo009, foo010, ..., foo278.  And

              rename .htm .html *.htm

       will fix the extension of your html files.  Provide an empty string for  shorten‐
       ing:

              rename '_with_long_name' '' file_with_long_name.*

       will remove the substring in the filenames.
       删除掉文件名中的字符串.

WARNING
       The  renaming has no safeguards except the --no-act option.  If the user has per‐
       mission to rewrite file names, the command will perform the  action  without  any
       questions.   For example, the result can be quite drastic when the command is run
       as root in the /lib directory.  Always make a backup before running the  command,
       unless you truly know what you are doing.

EXIT STATUS
              0      all requested rename operations were successful
              1      all rename operations failed
              2      some rename operations failed
              4      nothing was renamed
              64     unanticipated error occurred

SEE ALSO
       mv(1)

AVAILABILITY
       The  rename  command  is  part  of  the  util-linux package and is available from
       https://www.kernel.org/pub/linux/utils/util-linux/.

util-linux                              June 2011                              RENAME(1)
```

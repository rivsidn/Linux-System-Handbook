两个参数的情况。

| SOURCE   | DEST     | 解释                               |
| -------- | -------- | ---------------------------------- |
| 普通文件 | 普通文件 | 覆盖已有文件(重命名)               |
| 普通文件 | 目录     | 普通文件移动带目录下               |
| 普通文件 | 目录(-T) | 失败                               |
| 普通文件 | 不存在   | 重命名                             |
| 目录     | 普通文件 | 失败                               |
| 目录     | 目录     | 移动到目录下                       |
| 目录     | 目录(-T) | 目录重命名，如果目的目录非空则失败 |
| 目录     | 不存在   | 重命名                             |



```
MV(1)                                 User Commands                                MV(1)

NAME
       mv - move (rename) files
            移动或者重命名文件

SYNOPSIS
       mv [OPTION]... [-T] SOURCE DEST		//将DEST当作普通文件
       mv [OPTION]... SOURCE... DIRECTORY	//将文件移动到目录下
       mv [OPTION]... -t DIRECTORY SOURCE...	//将文件移动到目录下

       多个文件的时候，有两种可能，可以参照后边两种命令形式。

DESCRIPTION
       Rename SOURCE to DEST, or move SOURCE(s) to DIRECTORY.
       重命名或移动到目录

       Mandatory arguments to long options are mandatory for short options too.
       长选项的强制参数对短选项来说同样也是强制的.

       --backup[=CONTROL]
              make a backup of each existing destination file
	      如果文件已经存在，则作为已存在文件的备份

       -b     like --backup but does not accept an argument
              与备份类似但是不接受参数

       -f, --force
              do not prompt before overwriting
	      覆盖之前不需要提示

       -i, --interactive
              prompt before overwrite
	      覆盖之前提示

       -n, --no-clobber
              do not overwrite an existing file
	      不要覆盖一个已经存在的文件

       If you specify more than one of -i, -f, -n, only the final one takes effect.
       如果指定了上述参数的多个，只生效最后一个.

       --strip-trailing-slashes
              remove any trailing slashes from each SOURCE argument
	      删除跟随在每个SOURCE 参数后的'/'

       -S, --suffix=SUFFIX
              override the usual backup suffix
	      覆盖正常的备份文件尾缀

       -t, --target-directory=DIRECTORY
              move all SOURCE arguments into DIRECTORY
	      将SOURCE 参数移动到目录中

       -T, --no-target-directory
              treat DEST as a normal file
	      DEST文件为正常文件

       -u, --update
              move  only when the SOURCE file is newer than the destination file or when
              the destination file is missing
	      只有在SOURCE 文件比目的文件更新或不存在的时候才移动

       -v, --verbose
              explain what is being done
	      解释正在干什么

       -Z, --context
              set SELinux security context of destination file to default type
	      设置目的文件的SElinux上下文为默认类型

       --help display this help and exit
       显示帮助信息然后退出

       --version
              output version information and exit
	      输出版本信息

       The backup suffix is '~', unless set with --suffix or SIMPLE_BACKUP_SUFFIX.   The
       version  control  method  may  be selected via the --backup option or through the
       VERSION_CONTROL environment variable.  Here are the values:

       none, off
              never make backups (even if --backup is given)
	      不做备份

       numbered, t
              make numbered backups
	      数字形式的备份

       existing, nil
              numbered if numbered backups exist, simple otherwise
	      如果数字形式的备份存在，则使用数字形式的备份，否则是simple

       simple, never
              always make simple backups
	      简单备份

AUTHOR
       Written by Mike Parker, David MacKenzie, and Jim Meyering.

REPORTING BUGS
       GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
       Report mv translation bugs to <http://translationproject.org/team/>

COPYRIGHT
       Copyright © 2017 Free Software Foundation, Inc.  License GPLv3+: GNU GPL  version
       3 or later <http://gnu.org/licenses/gpl.html>.
       This  is  free software: you are free to change and redistribute it.  There is NO
       WARRANTY, to the extent permitted by law.

SEE ALSO
       rename(2)

       Full documentation at: <http://www.gnu.org/software/coreutils/mv>
       or available locally via: info '(coreutils) mv invocation'

GNU coreutils 8.28                    January 2018                                 MV(1)
```

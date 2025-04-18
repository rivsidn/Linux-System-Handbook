
target remote :1234

set $source_cnt = 0
break do_source_ext
commands
	set $source_cnt = $source_cnt + 1
	if $source_cnt < 20
		continue
	end
	load_breaks
end

define load_breaks
	break vim_main2
	break source_in_path
	break do_in_path_and_pp
	break do_in_path
	break source_callback
	break do_source
end

# /usr/share/vim/vim91/colors/lists/default.vim 加载过程
# set $source_cnt = 0
# break do_source_ext
# commands
# 	set $source_cnt = $source_cnt + 1
# 	if $source_cnt < 5
# 		continue
# 	end
# 	load_breaks
# end
# 
# # 添加断点
# define load_breaks
# 	set $one_cmd_cnt = 0
# 	break do_one_cmd
# 	commands
# 		set $one_cmd_cnt = $one_cmd_cnt + 1
# 		if $one_cmd_cnt < 48
# 			continue
# 		end
# 	end
# 	break do_ucmd
# 	break do_cmdline
# end
# 
# # 最终调用
# break load_default_colors_lists

# 涉及的调用栈顺序
# do_cmdline
# do_ucmd
# do_one_cmd
# do_cmdline
# do_source_ext
# do_source


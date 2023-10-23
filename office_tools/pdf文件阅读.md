

```perl
#! /usr/bin/perl

# 处理pdf粘贴到txt的文本，转换成azw3时方便阅读

# 将同一段落的内容置于一行

my $flag = 0;

while (<>) {
	if (/^```/) {
		print "\n";
		$flag ^= 1;
		next;
	}
	# ```内的行需要保留换行符
	if ($flag) {
		print $_;
		next;
	}
	# 句号, 冒号结尾的行需要保留换行符
	if (/[.:]$/) {
		print $_;
		next;
	}
	# 标题需要保留换行符
	if (/^[\d]+.[\d]+/) {
		print $_;
		next;
	}

	# 其他行删除换行符，输出
	chomp;
	print $_;
}
```



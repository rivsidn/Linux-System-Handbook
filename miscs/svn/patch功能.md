* 生成`patch`

  ```bash
  svn diff -r 421:438 > r421_438.patch
  ```

* 打`patch`

  ```bash
  svn patch r421_438.patch
  ```





> diff -r 421:438  是r421以后到r438，当前目录的所有修改，不包括r421修改。
> diff -r 421-438  是r421到r438，当前目录的所有修改，包括r421修改。
> diff -r 421:422  是r422，当前目录的所有修改，显示r422这个提交的修改。
> diff -c 422  跟上一行一样，表示r422的changes。
> diff -c -422  跟上一行相反，表示r422的反修改，提交这个patch就可以回退r422。





## 参考资料

* [svn patch 功能](https://www.cnblogs.com/rivsidn/p/10975018.html#_label0)




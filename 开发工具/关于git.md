# 概念
- 工作区：本地电脑存放项目文件的地方，比如learnGitProject文件夹；
- 暂存区（Index/Stage）：在使用git管理项目文件的时候，其本地的项目文件会多出一个.git的文件夹，将这个.git文件夹称之为版本库。


> `.git`文件夹中包含了两个部分，一个是暂存区（Index或者Stage）,顾名思义就是暂时存放文件的地方，通常使用add命令将工作区的文件添加到暂存区里；另一个是本地仓库（Repository）,通常使用commit 命令，将暂存区的文件添加到 本地仓库中

- 本地仓库：.git文件夹里还包括git自动创建的master分支，并且将HEAD指针指向master分支。使用commit命令可以将暂存区中的文件添加到本地仓库中；
- 远程仓库：不是在本地仓库中，项目代码在远程git服务器上，比如项目放在github上，就是一个远程仓库，通常使用clone命令将远程仓库拷贝到本地仓库中，开发后推送到远程仓库中即可

# git 命令参数

## --global

修改git的全局配置文件`~/.gitconfig`，而不是某个git仓库中的配置文件 `.git/config`




# git原理相关

## 支持的传输协议

Git 支持的传输协议有 ssh、git、http 和 https 协议（此外，ftp 和 ftps 也可用于拉取，但在 Git 官方文档中提到是低效且过时的，不建议使用）。其中原生传输协议（即 git:// URL）不做鉴权，在不安全的网络环境下应谨慎使用。

不同传输协议的使用示例


- ssh
```
ssh://[user@]host.xz[:port]/path/to/repo.git/ 或 [user@]host.xz:path/to/repo.git/
```

> 实例
```
git@github.com:cms-sw/cmssw.git
ssh://git@github.com/cms-sw/cmssw.git
```

- git

```
git://host.xz[:port]/path/to/repo.git/
```
- http / https
```
http[s]://host.xz[:port]/path/to/repo.git/
```
 > 实例
```
http://github.com/cms-sw/cmssw.git
https://github.com/cms-sw/cmssw.git
```

- ftp / ftps
```
ftp[s]://host.xz[:port]/path/to/repo.git/
```

**常用的传输协议有:HTTP/HTTPS、SSH**

# branch分支操作
- git branch -D 【分支名】
删除本地分支

- git branch 【远程仓库名】 -D 【分支名】
删除远程仓库的分支

# merge合并

- `git merge 【分支名】`

将指定分支合并到当前分支

# stash暂存
简介：实质上是将代码保存到了一个栈结构里

## 操作
### 入栈
- git stash

保存当前未commit的代码

- git stash save "备注的内容"

保存当前未commit的代码并添加备注


### 出栈

- git stash pop
从栈中弹出最近的一条记录，并应用

- git stash apply
应用栈中保存的最近的一条记录，但是不会动栈中的内容


> 当有多条 stash，可以指定操作stash
>- 语法：git stash apply 【栈索引】
```sh
$ git stash apply stash@{1}
```

### 清空栈

- git stash drop



- git stash clear

### 查看栈

- git stash list
查看栈中所有的记录


```sh
$ git stash list
stash@{0}: WIP on ...
stash@{1}: WIP on ...
stash@{2}: On ...
```

- git stash show 【栈索引】


## 实际应用场景

假设你的本地仓库和远程仓库的commit是同步的，可以使用 `git checkout`进行分支切换。假设某天，你正在feature分支上开发新功能，这时候生产环境中有一个bug需要修复，你需要切换到master分支处理bug，但是问题是：你在该分支的功能还没有开发完成，你此时的工作区是不干净的，不能强制切换到master分支，强行切换会报出下面的错误
```sh
error: Your local changes to the following files would be overwritten by checkout:
        1.js
        ...
Please commit your changes or stash them before you switch branches.
Aborting
```
你需要先进行commit来保证工作区是干净的，由于情况紧急，你只有急忙 commit 上去，commit 信息也随便写了个“暂存代码”，于是该分支提交记录就留了一条黑历史...

**正确的做法**

- 在feature分支上执行`git stash`命令暂存工作区没有commit的代码
- 切换到master分支进行bug的处理
- 切换回 feature分支,执行`git stash pop`,即可恢复代码，继续原来的功能开发



# rebase 变基


# commit提交

## 提交时的scope
> [【掘金】](https://juejin.cn/post/7133045617877581831)

- feat: 新功能、新特性
- fix: 修改 bug
- perf: 更改代码，以提高性能（在不影响代码内部行为的前提下，对程序性能进行优化）
- refactor: 代码重构（重构，在不影响代码内部行为、功能下的代码修改）
- docs: 文档修改
- style: 代码格式修改, 注意不是 css 修改（例如分号修改）
- test: 测试用例新增、修改
- build: 影响项目构建或依赖项修改
- revert: 恢复上一次提交
- ci: 持续集成相关文件修改
- chore: 其他修改（不在上述类型中的修改）
- release: 发布新版本
- workflow: 工作流相关文件修改



# 查看git配置


```sh
# 方式一
git config --global --list
# 方式二
git config --list 
```

## 设置http代理

- 为什么要设置代理服务器？？？

代理服务器可以在客户端和服务器之间充当中间人服务器。

- 有什么作用？

常用于加速访问、访问控制、访问安全等。

- git的http代理有什么用？

举一个实际的场景。为保障公司内部网络安全、防止敏感数据泄露，在公司内网中，git访问互联网可能受到限制。

- git 使用 HTTP / HTTPS 传输协议的代理方法

```
git config --global http.proxy <protocol>://<host>:<port>
```
> 参数
- `<protocol>`:代理协议。厂用的协议有:`http/https/socks5`
- `<host>`:代理主机。使用本地代理主机`127.0.0.1`或`host`
- `<port>`：代理端口号。clash使用的通常是7890

> 示例

```sh
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890
```

## 取消http代理
```sh
git config --global --unset http.proxy
git config --global --unset https.proxy
```

## 针对特定仓库的http代理


如果直接设置 `http.proxy` ，所有域名（比如gitee、github、gitlab等）下的仓库都会走代理，我们也可以针对特定的域名走代理

> 操作方式

```
git config --global http.<url>.proxy <protocol>://<host>:<port>
```
- `<url>`:表示仅仅在该域名下使用代理

> 示例:下面设置了`<url>`为`https://github.com`,表示仅仅对github仓库中的代码使用代理

```
git config --global http.https://github.com.proxy http://127.0.0.1:7890
```

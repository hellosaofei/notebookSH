# 概念
- 工作区：本地电脑存放项目文件的地方，比如learnGitProject文件夹；
- 暂存区（Index/Stage）：在使用git管理项目文件的时候，其本地的项目文件会多出一个.git的文件夹，将这个.git文件夹称之为版本库。


> `.git`文件夹中包含了两个部分，一个是暂存区（Index或者Stage）,顾名思义就是暂时存放文件的地方，通常使用add命令将工作区的文件添加到暂存区里；另一个是本地仓库（Repository）,通常使用commit 命令，将暂存区的文件添加到 本地仓库中

- 本地仓库：.git文件夹里还包括git自动创建的master分支，并且将HEAD指针指向master分支。使用commit命令可以将暂存区中的文件添加到本地仓库中；
- 远程仓库：不是在本地仓库中，项目代码在远程git服务器上，比如项目放在github上，就是一个远程仓库，通常使用clone命令将远程仓库拷贝到本地仓库中，开发后推送到远程仓库中即可



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


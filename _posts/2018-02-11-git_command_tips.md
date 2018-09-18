---
layout: post
title: 😊 Git command tips
category: 其他
---

### 1️⃣ rename git branch name local and remote

1,rename the local branch to the new name

```
git branch -m old_name new_name
```

2,delete the old branch on remote - where <remote> is eg. origin

```
git push <remote> --delete old_name
```

3,push the new branch to remote

```
git push <remote> new_name
```

### 2️⃣ checkout a remote git branch 

https://stackoverflow.com/questions/1783405/how-do-i-check-out-a-remote-git-branch

```
git checkout -b test origin/test
```


### 3️⃣ push new branch and set upstream

```
git push --set-upstream haier feature/operaiton-reconstruct
```

### 4️⃣ remove .gitignore

[git忽略已经被提交的文件](https://segmentfault.com/q/1010000000430426)

[2.2 Git 基础 - 记录每次更新到仓库](https://git-scm.com/book/zh/v2/Git-%E5%9F%BA%E7%A1%80-%E8%AE%B0%E5%BD%95%E6%AF%8F%E6%AC%A1%E6%9B%B4%E6%96%B0%E5%88%B0%E4%BB%93%E5%BA%93)

```
git rm -r --cached out/*`
git add -A
git commit -m…
git push …
```


### 5️⃣ git merge —no-ff

http://www.ruanyifeng.com/blog/2012/07/git.html

```
git checkout master
git merge --no-ff develop
```
默认情况下，Git执行"快进式合并"（fast-farward merge），会直接将Master分支指向Develop分支

### 6️⃣ Github Keeping a fork update to date

https://help.github.com/articles/syncing-a-fork/

https://stackoverflow.com/questions/7244321/how-do-i-update-a-github-forked-repository

1,List the current configured remote repository for your fork.

```
➜  mybatis-3 git:(master) git remote -v
origin	git@github.com:LaudOak/mybatis-3.git (fetch)
origin	git@github.com:LaudOak/mybatis-3.git (push)
```

2,Specify a new remote upstream repository that will be synced with the fork.

```
➜  mybatis-3 git:(master) git remote add upstream git@github.com:mybatis/mybatis-3.git
```

3,Verify the new upstream repository you've specified for your fork.

```
➜  mybatis-3 git:(master) git remote -v
origin	git@github.com:LaudOak/mybatis-3.git (fetch)
origin	git@github.com:LaudOak/mybatis-3.git (push)
upstream	git@github.com:mybatis/mybatis-3.git (fetch)
upstream	git@github.com:mybatis/mybatis-3.git (push)
```

4,Fetch the branches and their respective commits from the upstream repository. Commits to master will be stored in a local branch, upstream/master.

```
➜  mybatis-3 git:(master) git fetch upstream
From github.com:mybatis/mybatis-3
 * [new branch]          3.2.x      -> upstream/3.2.x
 * [new branch]          3.3.x      -> upstream/3.3.x
 * [new branch]          gh-pages   -> upstream/gh-pages
 * [new branch]          master     -> upstream/master
```

5,Check out your fork's local master branch.

```
$ git checkout master
```

6,Merge the changes from upstream/master into your local master branch. This brings your fork's master branch into sync with the upstream repository, without losing your local changes.

```
➜  mybatis-3 git:(master) git merge upstream/master
Already up-to-date.
```

### 7️⃣ undo merge

[Undo a Git merge that hasn't been pushed yet
](https://stackoverflow.com/questions/2389361/undo-a-git-merge-that-hasnt-been-pushed-yet)

If during the merge you get a conflict, the best way to undo the merge is:

```
git merge --abort
```


### 8️⃣ find deleted file in commit history

[Git: How to find a deleted file in the project commit history?
](https://stackoverflow.com/questions/7203515/git-how-to-find-a-deleted-file-in-the-project-commit-history)

```
 git log --diff-filter=D --summary | grep delete
```

![20180918160756.png](https://i.loli.net/2018/09/18/5ba0b26c6e14d.png)

```
git log --all -- file
```

![20180918160945.png](https://i.loli.net/2018/09/18/5ba0b2e6e6695.png)


### 9️⃣
### 🔟


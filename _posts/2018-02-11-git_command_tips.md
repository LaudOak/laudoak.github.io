---
layout: post
title: 😊 Git command tips
category: 其他
---

### rename git branch name local and remote

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

### checkout  a remote git branch 

https://stackoverflow.com/questions/1783405/how-do-i-check-out-a-remote-git-branch

```
git checkout -b test origin/test
```


### push new branch and set upstream

```
git push --set-upstream haier feature/operaiton-reconstruct
```

### remove .gitignore

git忽略已经被提交的文件(https://segmentfault.com/q/1010000000430426)

```
git rm -r --cached out/*`
git add -A
git commit -m…
git push …
```


### git merge —no-ff

http://www.ruanyifeng.com/blog/2012/07/git.html

```
git checkout master
git merge --no-ff develop
```
认情况下，Git执行"快进式合并"（fast-farward merge），会直接将Master分支指向Develop分支

### Github Keeping a fork update to date

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
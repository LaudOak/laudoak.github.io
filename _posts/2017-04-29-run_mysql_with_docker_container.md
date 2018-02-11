---
layout: post
title: Run MySQL with Docker Container
category: 数据库
---

## docker pull

```
docker pull hub.c.163.com/library/mysql:latest
```

 > docker pull [OPTIONS] NAME[:TAG|@DIGEST]

## docker run

```
docker run --name mysql -e MYSQL_ROOT_PASSWORD=laudoak@reeu -d -p 3306:3306 hub.c.163.com/library/mysql:latest
```

 > docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

-e, --env list                              Set environment variables (default [])

-d, --detach                                Run container in background and print container ID

-p, --publish list                          Publish a container's port(s) to the host (default [])

-P, --publish-all                           Publish all exposed ports to random ports

## problem encountered

 - docker: Error response from daemon: Conflict. The container name "/mysql" is already in use by container 1cba528629196a1e7489a384fe59eb756a690ec0bbecbe5b63e2e0c48767a02c. You have to remove (or rename) that container to be able to reuse that name..

 - Error response from daemon: conflict: unable to delete d5127813070b (must be forced) - image is being used by stopped container 3718fc83dd29

 - docker: Error response from daemon: driver failed programming external connectivity on endpoint mysql (a78e08069291ccb928ee126d9cb9c1ea8394cf17080c0243a0d6c26eb29da458): Error starting userland proxy: listen tcp 0.0.0.0:3306: bind: address already in use.

 > docker rm [OPTIONS] CONTAINER [CONTAINER...]

Remove one or more containers

 > docker rmi [OPTIONS] IMAGE [IMAGE...]

Remove one or more images
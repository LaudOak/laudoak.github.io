#!/bin/sh

echo === sending ===

git add .
msg=":memo:post at "$(date)""
git commit -am "${msg}"
git push origin master

echo === completed ===

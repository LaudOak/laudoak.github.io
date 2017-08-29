#!/bin/sh

echo === sending ===

msg=":memo:post at "$(date)""
git add .
git commit -am "${msg}"
git push origin master

echo === completed ===

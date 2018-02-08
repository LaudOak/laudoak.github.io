#!/bin/sh

echo === sending ===

msg=":memo:post at "$(date)""
git commit -am "${msg}"
git push origin master

echo === completed ===

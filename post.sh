#!/bin/sh

echo ===summitting===

msg=":memo:post at "$(date)""
git add .
git commit -am "${msg}"
git push origin master

echo ===completed===

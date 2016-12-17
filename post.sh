#!/bin/sh

echo ===summitting===

msg=":memo:"
git add .
git commit -am ${msg}
git push origin master

echo ===completed===

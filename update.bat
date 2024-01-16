@echo off
:: 获取当前脚本的路径
echo 当前脚本的路径是： %~dp0
cd /d %~dp0
git pull
git add -A .
git commit -m "update"
git push origin master

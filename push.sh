# 该文件用于自动化提交本地仓库

info="$1"

git add .
git commit -m "${info}"

git push origin main
#!sh

cur_date="`date +%Y-%m-%d`"

git add -A
git commit -m $cur_date
git push origin master

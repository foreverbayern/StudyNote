git pull origin master
echo.

git add *

set /p commitMessage=������ע��:

git commit -m "%commitMessage%"

git push origin master
echo.
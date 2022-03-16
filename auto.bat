git pull origin master
echo.

git add *

set /p commitMessage=ÇëÊäÈë×¢ÊÍ:

git commit -m "%commitMessage%"

git push origin master
echo.
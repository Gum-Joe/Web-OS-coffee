echo Web-OS compiler + installer v1.0
echo Copyright Gum-Joe
echo This is for app veyor

echo ""
cd ..

echo Installing bower and mocha
npm install -g bower mocha

echo Installing npm packages...
npm install

echo ""

echo Compiling apps...
cd app/console-app
compile.bat

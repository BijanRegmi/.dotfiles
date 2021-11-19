BASEDIR=$(dirname "$0")
col="\e[0;92m"
reset="\e[0m"

cd $BASEDIR

echo -e "$col[+] Downloading st version 0.8.4$reset"
wget https://dl.suckless.org/st/st-0.8.4.tar.gz

echo -e "$col[+] Unziping$reset"
tar -xvzf st-0.8.4.tar.gz

cd st-0.8.4

echo -e "$col[+] Applying Patches$reset"
patch < ../scroll+redraw.diff
patch < ../alpha.diff
patch < ../delkey.diff
patch < ../personalConfigs.diff

echo -e "$col[+] Compiling$reset"
cp config.def.h config.h
sudo make install

echo -e "$col[+] Cleaning$reset"
cd ..
sudo rm -r st-0.8.4
rm st-0.8.4.tar.gz

echo -e "$col[+] Done$reset"
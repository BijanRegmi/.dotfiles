set -e

green="\e[0;92m"
red="\e[0;91m"
yellow="\e[0;33m"
reset="\e[0m"

BASEDIR=$(dirname "$0")
cd $BASEDIR

function create_links(){
    echo -e "\n$green[+] Creating links$reset"
    if [[ -d $2 || -f $2 ]]
    then
        echo -e "\n$red[!] Old config folder exists!$reset"
        echo -e "\n$yellow[*] Moving them to .bak folder$reset"
        mkdir -p $2.bak/
        mv $2 $2.bak/
    fi
    ln -s $1 $2
}

function st_install(){
    mkdir -p tmp
    cd tmp

    echo -e "\n$green[+] Downloading st version 0.8.4$reset"
    wget https://dl.suckless.org/st/st-0.8.4.tar.gz

    echo -e "\n$green[+] Unziping$reset"
    tar -xvzf st-0.8.4.tar.gz

    echo -e "\n$green[+] Applying Patches:$reset"
    cd st-0.8.4
    echo -e "\n$yellow[1] Scroll+redraw$reset"
    patch < ../../st/scroll+redraw.diff
    echo -e "\n$yellow[2] Alpha/Transparency$reset"
    patch < ../../st/alpha.diff
    echo -e "\n$yellow[3] Enable del key$reset"
    patch < ../../st/delkey.diff
    echo -e "\n$yellow[4] Personal preferences$reset"
    patch < ../../st/personalConfigs.diff

    echo -e "\n$green[+] Compiling$reset"
    cp config.def.h config.h
    sudo make install

    echo -e "\n$green[+] Cleaning Up$reset"
    cd ../../
    sudo rm -r tmp

    echo -e "\n$green[+] Installation of st complete :)$reset"
}

function dwm_install(){
    mkdir -p tmp
    cd tmp

    echo -e "\n$green[+] Downloading dwm version 6.2$reset"
    wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz

    echo -e "\n$green[+] Unziping$reset"
    tar -xvzf dwm-6.2.tar.gz

    echo -e "\n$green[+] Applying all in one patch lol$reset"
    cd dwm-6.2
    patch < ../../dwm/allInOne.diff

    cp config.def.h config.h
    echo -e "\n$green[+] Compiling$reset"
    sudo make install

    cd ../../
    create_links $(pwd)/dwm/autostart.sh /home/$USER/.dwm/autostart.sh

    echo -e "\n$green[+] Cleaning Up$reset"
    sudo rm -r tmp

    echo -e "\n$green[+] Installation of dwm complete :)$reset"
}

function rofi_install(){
    echo -e "\n$green[+] Installing rofi$reset"
    sudo pacman -S rofi

    create_links $(pwd)/rofi /home/$USER/.config/rofi

    echo -e "\n$green[+] Installation of rofi complete :)$reset"
}

function ranger_install(){
    echo -e "\n$green[+] Installing ranger$reset"
    sudo pacman -S ranger

    create_links $(pwd)/ranger /home/$USER/.config/ranger
    echo -e "\n$green[+] Installation of ranger complete :)$reset"
}


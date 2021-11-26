set -e

green="\e[0;92m"
red="\e[0;91m"
yellow="\e[0;33m"
reset="\e[0m"

BASEFULLDIR=$(realpath $(dirname "$0"))
TMPDIR=$BASEFULLDIR/tmp

cd $BASEFULLDIR
mkdir -p tmp
cd $TMPDIR

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

function cleanup(){
    cd $BASEFULLDIR
    rm -r tmp
}

function st_install(){
    cd $TMPDIR

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
    echo -e "\n$yellow[4] NewTerm in cwd$reset"
    patch < ../../st/newterm.diff

    echo -e "\n$green[+] Compiling$reset"
    cp $BASEFULLDIR/st/config.h config.h
    sudo make install
    
    cd ..

    echo -e "\n$green[+] Installation of st complete :)$reset"
}

function dwm_install(){
    cd $TMPDIR

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

    cd $TMPDIR

    echo -e "\n$green[+] Installation of dwm complete :)$reset"
}

function rofi_install(){
    echo -e "\n$green[+] Installing rofi$reset"
    sudo pacman -S rofi

    create_links $BASEFULLDIR/rofi /home/$USER/.config/rofi

    echo -e "\n$green[+] Installation of rofi complete :)$reset"
}

function ranger_install(){
    echo -e "\n$green[+] Installing ranger$reset"
    sudo pacman -S ranger

    create_links $BASEFULLDIR/ranger /home/$USER/.config/ranger
    echo -e "\n$green[+] Installation of ranger complete :)$reset"
}

function nvim_install(){
    echo -e "\n$green[+] Installing neovim$reset"
    sudo pacman -S neovim

    echo -e "\n$green[+] Working on Plugins:$reset"
    create_links $BASEFULLDIR/nvim /home/$USER/.config/nvim

    echo -e "\n$green[+] Installation of neovim complete :)$reset"
}

function neofetch_install(){
    echo -e "\n$green[+] Installing neofetch$reset"
    sudo pacman -S neofetch

    create_links $BASEFULLDIR/neofetch /home/$USER/.config/neofetch

    echo -e "\n$green[+] Installation of neofetch complete :)$reset"
}

highlight () {
    local ch=$1-1
    if [[ ${selections[ch]} == "*" ]]; then
        selections[ch]=
    else
        selections[ch]=*
    fi
}

menu() {
    clear
    for i in ${!options[@]}; do 
        printf "[%1s] %d. %s\n" "${selections[i]}" "$((i+1))" "${options[i]}"
    done
    echo -ne "$prompt"
}

options=("st" "dwm" "rofi" "ranger" "neovim" "neofetch" "cleanup")
install_fxn=(st_install dwm_install rofi_install ranger_install nvim_install neofetch_install cleanup)

prompt="Select components to install. Input 0 once done selecting: "
menu
while read ch; do
    if [ $ch -eq 0 ]; then
        break
    elif [ $ch -ge 0 ] && [ $ch -le ${#options[@]} ]; then
        highlight $ch
    else
        prompt="Invalid Number\nSelect components to install. Input 0 once done selecting: "
    fi

    menu
    prompt="Select components to install. Input 0 once done selecting: "
done

for i in ${!options[@]}; do 
    [[ "${selections[i]}" == "*" ]] && { printf "\n$green[#] Executing option: %s$reset\n" "${options[i]}";} && ${install_fxn[i]}
done
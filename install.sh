set -e

green="\e[0;92m"
red="\e[0;91m"
yellow="\e[0;33m"
blue="\e[1;34m"
purple="\e[1;35m"
reset="\e[0m"

BASEFULLDIR=$(realpath $(dirname "$0"))
TMPDIR=$BASEFULLDIR/tmp

cd $BASEFULLDIR
mkdir -p tmp
cd $TMPDIR

function create_links(){
    echo -e "\n$blue[+] Creating links$reset"
    if [[ -d $2 || -f $2 ]]
    then
        echo -e "\n$red[!] Old config exists!$reset"
        echo -e "\n$blue[+] Moving them to $2.bak folder$reset"
        mkdir -p $2.bak/
        mv $2 $2.bak/
    fi
    ln -s $1 $2
    echo -e "\n$green[*] Linking success from $1 to $2$reset"
}

function cleanup(){
    cd $BASEFULLDIR
    sudo rm -r tmp
    echo -e "\n$green[*] Temporary folders cleaned$reset"
}

function st_install(){
    cd $TMPDIR

    echo -e "\n$blue[+] Downloading st version 0.8.4$reset"
    wget https://dl.suckless.org/st/st-0.8.4.tar.gz

    echo -e "\n$blue[+] Unziping$reset"
    tar -xvzf st-0.8.4.tar.gz

    echo -e "\n$blue[+] Applying Patches:$reset"
    cd st-0.8.4
    echo -e "\n$yellow[1] Scroll+redraw$reset"
    patch < ../../st/scroll+redraw.diff
    echo -e "\n$yellow[2] Alpha/Transparency$reset"
    patch < ../../st/alpha.diff
    echo -e "\n$yellow[3] Enable del key$reset"
    patch < ../../st/delkey.diff
    echo -e "\n$yellow[4] NewTerm in cwd$reset"
    patch < ../../st/newterm.diff

    echo -e "\n$blue[+] Compiling$reset"
    cp $BASEFULLDIR/st/config.h config.h
    sudo make install
    
    cd $TMPDIR

    echo -e "\n$green[#] Installation of st complete :)$reset"
}

function dwm_install(){
    cd $TMPDIR

    echo -e "\n$blue[+] Downloading dwm version 6.2$reset"
    wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz

    echo -e "\n$blue[+] Unziping$reset"
    tar -xvzf dwm-6.2.tar.gz

    echo -e "\n$blue[+] Applying Patches$reset"
    cd dwm-6.2
    echo -e "\n$yellow[1] IPC$reset"
    patch < ../../dwm/ipc_patch.diff
    echo -e "\n$yellow[2] VanityGaps$reset"
    patch < ../../dwm/vanitygaps.diff
    echo -e "\n$yellow[3] AnyBar$reset"
    patch < ../../dwm/anybar.diff
    echo -e "\n$yellow[4] AutoStart$reset"
    patch < ../../dwm/autostart.diff
    echo -e "\n$yellow[5] ActualFullScreen$reset"
    patch < ../../dwm/fullscreen.diff
    echo -e "\n$yellow[6] StickyClient$reset"
    patch < ../../dwm/sticky.diff
    echo -e "\n$yellow[7] AlphaBar$reset"
    patch < ../../dwm/alpha.diff

    echo -e "\n$blue[+] Compiling$reset"
    cp $BASEFULLDIR/dwm/config.h config.h
    sudo make install

    create_links $BASEFULLDIR/dwm/autostart.sh /home/$USER/.dwm/autostart.sh

    cd $TMPDIR

    echo -e "\n$green[#] Installation of dwm complete :)$reset"
}

function rofi_install(){
    echo -e "\n$blue[+] Installing rofi$reset"
    sudo pacman -S rofi

    create_links $BASEFULLDIR/rofi /home/$USER/.config/rofi

    echo -e "\n$green[#] Installation of rofi complete :)$reset"
}

function ranger_install(){
    echo -e "\n$blue[+] Installing ranger$reset"
    sudo pacman -S ranger

    create_links $BASEFULLDIR/ranger /home/$USER/.config/ranger
    echo -e "\n$green[#] Installation of ranger complete :)$reset"
}

function nvim_install(){
    echo -e "\n$blue[+] Installing neovim$reset"
    sudo pacman -S neovim

    echo -e "\n$green[+] Working on Plugins:$reset"
    create_links $BASEFULLDIR/nvim /home/$USER/.config/nvim

    echo -e "\n$green[#] Installation of neovim complete :)$reset"
}

function neofetch_install(){
    echo -e "\n$blue[+] Installing neofetch$reset"
    sudo pacman -S neofetch

    create_links $BASEFULLDIR/neofetch /home/$USER/.config/neofetch

    echo -e "\n$green[#] Installation of neofetch complete :)$reset"
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
 selections=(" "  " "   " "    " "      " "      " "        "*")
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
    [[ "${selections[i]}" == "*" ]] && { printf "\n$purple[*] Executing option: %s$reset\n" "${options[i]}";} && ${install_fxn[i]}
done
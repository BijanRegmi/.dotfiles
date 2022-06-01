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
        cp $2 $2.bak/ -L -r
        rm $2 -rf
    fi
    ln -s $1 $2
    echo -e "\n$green[*] Linking success from $1 to $2$reset"
}

function cleanup(){
    cd $BASEFULLDIR
    sudo rm -r tmp
    echo -e "\n$green[*] Temporary folders cleaned$reset"
}

function install_dep(){
    sudo pacman -S --needed --noconfirm\
        xorg xbindkeys pulseaudio pavucontrol xbindkeys redshift bc\
        python-pywal sxiv mpv mpd ncmpcpp youtube-dl flameshot\
        vscode
}

function configure_lightdm(){
    sudo pacman -S --needed --noconfirm lightdm
    yay -S lightdm-webkit-theme-aether
}

function dunst_install(){
    cd $TMPDIR

    echo -e "\n$blue[+] Downloading dunst-double border fork$reset"
    git clone https://github.com/Barbarossa93/dunst
    cd dunst

    echo -e "\n$blue[+] Compiling$reset"
    sudo make install

    create_links $BASEFULLDIR/dunst ~/.config/dunst
    echo -e "\n$green[#] Installation of dunst complete :)$reset"
}

function nitrogen_install(){
    echo -e "\n$blue[+] Installing nitrogen from pacman$reset"
    sudo pacman -S nitrogen

    create_links $BASEFULLDIR/nitrogen ~/.config/nitrogen
    echo -e "\n$green[#] Installation of nitrogen complete :)$reset"
}

function st_install(){
    cd $BASEFULLDIR/st

    echo -e "\n$blue[+] Compiling$reset"
    sudo make install
    
    cd $TMPDIR
    echo -e "\n$green[#] Installation of st complete :)$reset"
}

function dwm_install(){
    cd $BASEFULLDIR/dwm

    echo -e "\n$blue[+] Installing dependency$reset"
    sudo pacman -S --needed yajl noto-fonts-cjk

    echo -e "\n$blue[+] Compiling$reset"
    sudo make install

    mkdir -p /home/$USER/.dwm
    create_links $BASEFULLDIR/dwm/autostart.sh /home/$USER/.dwm/autostart.sh
    cd $TMPDIR
    echo -e "\n$green[#] Installation of dwm complete :)$reset"
}

function rofi_install(){
    echo -e "\n$blue[+] Installing rofi$reset"
    sudo pacman -S --needed --noconfirm rofi

    create_links $BASEFULLDIR/rofi /home/$USER/.config/rofi
    echo -e "\n$green[#] Installation of rofi complete :)$reset"
}

function ranger_install(){
    echo -e "\n$blue[+] Installing ranger$reset"
    sudo pacman -S --needed --noconfirm ranger ueberzug

    create_links $BASEFULLDIR/ranger /home/$USER/.config/ranger
    echo -e "\n$green[#] Installation of ranger complete :)$reset"
}

function nvim_install(){
    echo -e "\n$blue[+] Installing neovim$reset"
    sudo pacman -S --needed --noconfirm neovim

    echo -e "\n$green[+] Working on Plugins:$reset"
    create_links $BASEFULLDIR/nvim /home/$USER/.config/nvim
    echo -e "\n$green[#] Installation of neovim complete :)$reset"
}

function neofetch_install(){
    echo -e "\n$blue[+] Installing neofetch$reset"
    sudo pacman -S --needed --noconfirm neofetch

    create_links $BASEFULLDIR/neofetch /home/$USER/.config/neofetch
    echo -e "\n$green[#] Installation of neofetch complete :)$reset"
}

function picom_install(){
    echo -e "\n$blue[+] Installing picom-ibhagwan fork$reset"
    yay -S picom-ibhagwan-git

    create_links $BASEFULLDIR/picom ~/.config/picom
    echo -e "\n$green[#] Installation of picom complete :)$reset"
}

function polybar_install(){
    cd $TMPDIR
    
    echo -e "\n$blue[+] Installing polybar-dwm-module fork$reset"
    echo -e "\n$red[-] If any errors occur please install the dependencies mentioned in the error log.$reset"
    git clone https://github.com/nixenos/polybar-dwm-module
    cd polybar-dwm-module

    echo -e "\n$blue[+] Installing custom module dependencies$reset"
    sudo pacman -S --needed --noconfirm bc
    echo -e "\n$blue[+] Building$reset"
    ./build.sh -d
    
    create_links $BASEFULLDIR/polybar ~/.config/polybar
    echo -e "\n$green[#] Installation of polybar complete :)"
}

# Menu Functions
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

# Parameters
    options=("st" "dwm" "rofi" "ranger" "neovim" "neofetch" "dunst" "nitrogen" "polybar" "picom" "lightdm" "deps" "cleanup")
 selections=(" "  " "   " "    " "      " "      " "        " "     " "        " "       " "     " "        " "    "*")
install_fxn=(st_install dwm_install rofi_install ranger_install nvim_install neofetch_install dunst_install nitrogen_install polybar_install picom_install configure_lightdm install_dep cleanup)
prompt="Select components to install. Press enter once done selecting: "

# Main Loop
menu
while read ch; do
    echo $ch
    if [[ $ch = "" ]]; then
        break
    elif [ $ch -ge 0 ] && [ $ch -le ${#options[@]} ]; then
        highlight $ch
    else
        prompt="Invalid Number\nSelect components to install. Press enter once done selecting: "
    fi

    menu
    prompt="Select components to install. Press enter once done selecting: "
done

# Execute
for i in ${!options[@]}; do 
    [[ "${selections[i]}" == "*" ]] && { printf "\n$purple[*] Executing option: %s$reset\n" "${options[i]}";} && ${install_fxn[i]}
done

# BEGIN COLORS
green=$'\e[0;92m'
red=$'\e[0;91m'
blue=$'\e[1;34m'
reset=$'\e[0m'
# END COLORS

# BEGIN PRE_CHROOT
echo -e "${green}Setting Mirrors${reset}"
reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo -e "${green}Setting keyboard layout${reset}"
pacman --noconfirm -Sy archlinux-keyring
loadkeys us

echo -e "${green}Setting Time${reset}"
timedatectl set-ntp true

echo -e "${green}Disk Partitioning${reset}"
fdisk -l
read -p "${red}Drive to install Arch on? ${reset}" drive
fdisk $drive

read -p "${red}Enter efi partition: ${reset}" efipartition
read -p "${red}Enter root partition: ${reset}" rootpartition
mkfs.ext4 $rootpartition
mkfs.fat -F32 $efipartition
read -p "${red}Did you create swap partition?[y/n]${reset}" swapch
if [[ $swapch == [Yy]* ]]; then
    read -p "${red}Enter swap partition: ${reset}" swappartition
    mkswap $swappartition
    swapon $swappartition
fi
mount $rootpartition /mnt

echo -e "${green}Installing linux files${reset}"
pacstrap /mnt base linux linux-firmware

echo -e "${green}Generating fstab${reset}"
genfstab -U /mnt >> /mnt/etc/fstab

sed -n -e '/^# BEGIN COLORS/,/^# END COLORS/p' -e '/^# BEGIN POST_CHROOT/,/^# END POST_CHROOT/p' $0 > postchroot.sh
chmod +x postchroot.sh

echo -e "${blue}You can now chroot and run the postchroot.sh script.${reset}"
exit
# END PRE_CHROOT

# BEGIN POST_CHROOT
echo -e "${green}Configuring timezone${reset}"
ln -sf /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
hwclock --systohc

echo -e "${green}Setting locale${reset}"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
#-----------------------------------------------------------------------
read -p "${red}Enter your hostname: ${reset}" hostname
echo $hostname > /etc/hostname
echo "\
127.0.0.1     localhost
::1           localhost
127.0.1.1     $hostname.localdomain   $hostname" >> /etc/hosts

echo -e "${green}Setting password for root user\n${reset}"
passwd
read -p "${red}Enter new username: ${reset}" username
useradd -mG wheel,audio,video,optical,storage -s /bin/bash $username
passwd $username
pacman --noconfirm -S sudo
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
#-------------------------------------------------------------------------
echo -e "${green}Making initramfs${reset}"
mkinitcpio -P

echo -e "${green}Installing GRUB${reset}"
pacman --noconfirm -S grub efibootmgr os-prober
mkdir /boot/EFI
read -p "${red}Enter efipartition: ${reset}" efipartition
mount $efipartition /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
#-------------------------------------------------------------------
echo "${green}Configuring wifi${reset}"
pacman --noconfirm -S broadcom-wl iwd dhcpcd openresolv
systemctl enable iwd dhcpcd
echo "\
blacklist bcma
blacklist b43
blacklist b43legacy
blacklist brcm80211" >> /etc/modprobe.d/blacklist.conf
echo "\
ipv4only
noipv6
nodhcp6
noipv4ll" >> /etc/dhcpcd.conf
mkdir -p /etc/iwd
echo "\
[General]
UseDefaultInterface = true
RoamThreshold = 1
EnableNetworkConfiguration = true

[Network]
EnableIPv6 = false
NameResolvingService = resolvconf" >> /etc/iwd/main.conf
#---------------------------------------------------------------------------
echo -e "${green}Installing necessary programs${reset}"
sudo pacman -S --noconfirm base-devel mesa xf86-video-intel\
                git cmake ntfs-3g openssh\

echo -e "${green}Install aur-helper${reset}"
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd ..
rm -rf yay-git

yay -S backlight_control

echo -e "${blue}Everything is set you can now restart and proceed to rice${reset}"
# END POST_CHROOT

#!/bin/bash
clear
echo "UYARI BU SCRIPT INTEL KURULUM ICINDIR LUTFEN AMD ICIN KULLANMAYINIZ"
echo "UYARI BU SCRIPT DISK SIFRELEME ICERMEZ"
sleep 2
clear
echo "    _             _       ___           _        _ _ "
echo "   / \   _ __ ___| |__   |_ _|_ __  ___| |_ __ _| | |"
echo "  / _ \ | '__/ __| '_ \   | || '_ \/ __| __/ _' | | |"
echo " / ___ \| | | (__| | | |  | || | | \__ \ || (_| | | |"
echo "/_/   \_\_|  \___|_| |_| |___|_| |_|___/\__\__,_|_|_|"
echo ""
echo "by Samet1290"
echo "-----------------------------------------------------"
echo "Saat Dilimi Ayarlaniyor..."
echo "Bu Script Intel Kurulumlar için Tasarlanmistir."
echo "Bu Script Disk Şifreleme Icermez."
echo "-----------------------------------------------------"
echo ""
sleep 2
echo "-----------------------------------------------------"
echo "Saat Dilimi Ayarlaniyor. "
echo "-----------------------------------------------------"
timezone=$(curl -s https://ipinfo.io/timezone)
ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
hwclock -uw
timedatectl set-ntp 1
timedatectl set-timezone $timezone
timedatectl status && clear && sleep 0.1 && sleep 1 && date
clear
echo "-----------------------------------------------------"
echo "Saat Dilimi $timezone Olarak Ayarlandi. "
echo "-----------------------------------------------------"
sleep 2
echo "    _             _       ___           _        _ _ "
echo "   / \   _ __ ___| |__   |_ _|_ __  ___| |_ __ _| | |"
echo "  / _ \ | '__/ __| '_ \   | || '_ \/ __| __/ _' | | |"
echo " / ___ \| | | (__| | | |  | || | | \__ \ || (_| | | |"
echo "/_/   \_\_|  \___|_| |_| |___|_| |_|___/\__\__,_|_|_|"
echo ""
echo "by Samet"
echo "-----------------------------------------------------"
echo "Kurulum Baslatiliyor..."
echo "Bu Script Intel Kurulumlar icin Tasarlanmistir."
echo "Bu Script Disk Sifreleme Icermez."
echo "-----------------------------------------------------"
echo "aşağıda gösterileni yap:"
echo "Oncesi: #[multilib]"
echo "        #Include = /etc/pacman.d/mirrorlist"
echo "Sonrasi:[multilib]"
echo "        Include = /etc/pacman.d/mirrorlist"
echo ""
read -p "config dosyasini acayimmi?" c
vim /etc/pacman.conf
sleep 2
clear
echo "    _             _       ___           _        _ _ "
echo "   / \   _ __ ___| |__   |_ _|_ __  ___| |_ __ _| | |"
echo "  / _ \ | '__/ __| '_ \   | || '_ \/ __| __/ _' | | |"
echo " / ___ \| | | (__| | | |  | || | | \__ \ || (_| | | |"
echo "/_/   \_\_|  \___|_| |_| |___|_| |_|___/\__\__,_|_|_|"
echo ""
echo "by Samet"
echo "-----------------------------------------------------"
echo "Kurulum Baslatiliyor..."
echo "Bu Script Intel Kurulumlar icin Tasarlanmistir."
echo "Bu Script Disk Sifreleme Icermez."
echo "-----------------------------------------------------"
sleep 2
lsblk
read -p "EFI bolumunu giriniz (ornek sda1): " vda1
read -p "ROOT bolumunu giriniz (ornek sda2): " vda2
mkfs.fat -F 32 /dev/$vda1;
mkfs.btrfs -f /dev/$vda2
mount /dev/$vda2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
btrfs su cr /mnt/@log
umount /mnt
mount -o compress=zstd:1,noatime,subvol=@ /dev/$vda2 /mnt
mkdir -p /mnt/{boot/efi,home,.snapshots,var/{cache,log}}
mount -o compress=zstd:1,noatime,subvol=@cache /dev/$vda2 /mnt/var/cache
mount -o compress=zstd:1,noatime,subvol=@home /dev/$vda2 /mnt/home
mount -o compress=zstd:1,noatime,subvol=@log /dev/$vda2 /mnt/var/log
mount -o compress=zstd:1,noatime,subvol=@snapshots /dev/$vda2 /mnt/.snapshots
mount /dev/$vda1 /mnt/boot/efi
btrfs su l /mnt
lsblk -f
cd install-scripts/archinstall/
pacstrap -K /mnt intel-ucode btrfs-progs base base-devel linux-zen linux-lts linux-zen-headers linux-lts-headers linux-firmware linux-api-headers xdg-user-dirs xorg xorg-xinit xorg-appres sysfsutils xorg-xwayland wayland-utils xorg-xauth vim nano p7zip unzip unrar zip udisks2 gvfs-afc gvfs-mtp gvfs-gphoto2 gphoto2 sudo mkinitcpio git wget curl networkmanager openssh mlocate fastfetch inxi zsh noto-fonts ttf-dejavu ttf-dejavu-nerd ttf-roboto ttf-roboto-mono ttf-roboto-mono-nerd terminus-font gnu-free-fonts noto-fonts noto-fonts-emoji noto-fonts-extra ttf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-liberation ttf-liberation-mono-nerd ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols-common ttf-roboto ttf-roboto-mono ttf-roboto-mono-nerd awesome-terminal-fonts ttf-font-awesome otf-font-awesome pipewire pipewire-pulse pipewire-alsa pipewire-audio pipewire-jack lib32-pipewire lib32-pipewire-jack wireplumber alsa-tools alsa-utils alsa-firmware --noconfirm --needed
genfstab -LUp /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
sleep 10
mkdir /mnt/archinstall
cp /etc/zsh/zshrc /mnt/root/.zshrc
cp /etc/zsh/zprofile /mnt/root/.zprofile
cp 2-configuration.sh /mnt/archinstall/
cp 3-yay.sh /mnt/archinstall/
cp 4-zram.sh /mnt/archinstall/
cp 5-timeshift.sh /mnt/archinstall/
cp 6-preload.sh /mnt/archinstall/
cp snapshot.sh /mnt/archinstall/
echo "1. adim tamamlandi"
sleep 1
echo "2. adima geciliyor"
arch-chroot /mnt ./archinstall/2-configuration.sh
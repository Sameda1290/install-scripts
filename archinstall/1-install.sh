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
timezone=$(curl -s https://ipinfo.io/timezone)
ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
hwclock -uw
timedatectl set-ntp 1
timedatectl set-timezone $timezone
timedatectl status && clear && sleep 0.1 && sleep 1 && date
echo "-----------------------------------------------------"
echo "Saat Dilimi $timezone Olarak Ayarlandı. "
echo "-----------------------------------------------------"
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
echo "Uncomment %wheel group in sudoers (around line 85):"
echo "Oncesi: #[multilib]"
echo "        #Include = /etc/pacman.d/mirrorlist"
echo "Sonrasi:  [multilib]"
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
read -p "EFI bolumunu giriniz (ornek vda1): " vda1
read -p "ROOT bolumunu giriniz (ornek vda2): " vda2
mkfs.vfat -F32 -n /dev/$vda1;
mkfs.btrfs -f /dev/$vda2
mount -t btrfs -o defaults,rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,commit=120 /dev/$vda2 /mnt
cd /mnt
btrfs su cr @
btrfs su cr @/var
mkdir @/usr
btrfs su cr @/usr/local
btrfs su cr @/srv
btrfs su cr @/root
btrfs su cr @/opt
btrfs su cr @/tmp
btrfs su cr @/home
cd
umount /mnt
mount -t btrfs -o defaults,rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,commit=120,subvol=@,subvolid=256 /dev/$vda2 /mnt
mount -t btrfs -o defaults,rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,commit=120,subvol=@/var,subvolid=257 /dev/$vda2 /mnt/var
mount -t btrfs -o defaults,rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,commit=120,subvol=@/usr/local,subvolid=258 /dev/$vda2 /mnt/usr/local
mount -t btrfs -o defaults,rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,commit=120,subvol=@/srv,subvolid=259 /dev/$vda2 /mnt/srv
mount -t btrfs -o defaults,rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,commit=120,subvol=@/root,subvolid=260 /dev/$vda2 /mnt/root
mount -t btrfs -o defaults,rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,commit=120,subvol=@/opt,subvolid=261 /dev/$vda2 /mnt/opt
mount -t btrfs -o defaults,rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,commit=120,subvol=@/tmp,subvolid=262 /dev/$vda2 /mnt/tmp
mount -t btrfs -o defaults,rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,commit=120,subvol=@/home,subvolid=263 /dev/$vda2 /mnt/home
mount --mkdir -t vfat -o nodev,nosuid,noexec /dev/$vda1 /mnt/boot/efi
btrfs su l /mnt
lsblk -f
cd install-scripts/archinstall/
pacstrap -K /mnt intel-ucode btrfs-progs base base-devel linux linux-zen linux-lts linux-zen-headers linux-lts-headers linux-firmware linux-api-headers linux-headers xdg-user-dirs xorg xorg-xinit xorg-appres sysfsutils xorg-xwayland wayland-utils xorg-xauth vim nano p7zip unzip unrar zip udisks2 gvfs-afc gvfs-mtp gvfs-gphoto2 gphoto2 sudo mkinitcpio git wget curl networkmanager openssh mlocate neofetch inxi zsh noto-fonts ttf-dejavu ttf-dejavu-nerd ttf-roboto ttf-roboto-mono ttf-roboto-mono-nerd terminus-font gnu-free-fonts noto-fonts noto-fonts-emoji noto-fonts-extra ttf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-liberation ttf-liberation-mono-nerd ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols-common ttf-roboto ttf-roboto-mono ttf-roboto-mono-nerd awesome-terminal-fonts ttf-font-awesome otf-font-awesome pipewire pipewire-pulse pipewire-alsa pipewire-audio pipewire-jack lib32-pipewire lib32-pipewire-jack wireplumber alsa-tools alsa-utils alsa-firmware --noconfirm --needed
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
mkdir /mnt/archinstall
cp 2-configuration.sh /mnt/archinstall/
cp 3-yay.sh /mnt/archinstall/
cp 4-zram.sh /mnt/archinstall/
cp 5-timeshift.sh /mnt/archinstall/
cp 6-preload.sh /mnt/archinstall/
cp snapshot.sh /mnt/archinstall/
arch-chroot /mnt ./archinstall/2-configuration.sh


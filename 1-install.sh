#!/bin/bash
clear
echo "    _             _       ___           _        _ _ "
echo "   / \   _ __ ___| |__   |_ _|_ __  ___| |_ __ _| | |"
echo "  / _ \ | '__/ __| '_ \   | || '_ \/ __| __/ _' | | |"
echo " / ___ \| | | (__| | | |  | || | | \__ \ || (_| | | |"
echo "/_/   \_\_|  \___|_| |_| |___|_| |_|___/\__\__,_|_|_|"
echo ""
echo "by Samet"
echo "-----------------------------------------------------"
echo ""
echo "Important: Please make sure that you have followed the "
echo "manual steps in the README to partition the harddisc!"
echo "Warning: Run this script at your own risk."
echo ""
lsblk
read -p "Enter the name of the EFI partition (eg. sda1): " vda1
read -p "Enter the name of the ROOT partition (eg. sda2): " vda2
timedatectl set-ntp true
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
pacstrap -K /mnt base base-devel git linux linux-zen linux-firmware vim openssh reflector rsync intel-ucode
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


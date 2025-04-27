#!/usr/bin/env bash
# Expecting mbr, 
sudo parted /dev/sda --script mklabel msdos
sudo parted /dev/sda --script mkpart primary ext4 1MiB 513MiB
sudo parted /dev/sda --script set 1 boot on

sudo mkfs.ext4 -L boot /dev/sda1

sudo parted /dev/sda --script mkpart primary linux-swap 513MiB 8577MiB
sudo mkswap -L swap /dev/sda2
sudo swapon /dev/sda2

sudo parted /dev/sda --script mkpart primary ext4 8577MiB 100%
sudo mkfs.ext4 -L root /dev/sda3

sudo mount /dev/disk/by-label/root /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot

sudo nixos-install --flake github:pheis/nixos-basic#basic

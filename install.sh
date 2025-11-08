#!/usr/bin/env bash

# First cd into /tmp and git clone the repo

echo -e "\n======\nRunning Disko\n======\n\n"

sudo nix \
  --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko ./disko-config.nix

echo -e "\n======\nGenerating Config\n======\n\n"

sudo nixos-generate-config --no-filesystems --root /mnt

echo -e "\n======\nPopulating /mnt/etc/nixos \n======\n\n"

sudo mv * /mnt/etc/nixos
cd /mnt/etc/nixos

echo -e "\n======\nInstalling NixOS\n======\n\n"

sudo mkdir /mnt/tmp
TMPDIR=/mnt/tmp nixos-install --root /mnt --flake '.#nixos'

# sudo reboot

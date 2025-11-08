#!/usr/bin/env bash
set -e
set -u
set -o pipefail

if [ "$(id -u)" -ne 0 ]; then
   echo "Please run this script as root or using sudo" >&2
   exit 1
fi

# First cd into /tmp and git clone the repo

echo -e "\n======\nRunning Disko\n======\n\n"

nix \
  --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko ./disko-config.nix

echo -e "\n======\nGenerating Config\n======\n\n"

nixos-generate-config --no-filesystems --root /mnt

echo -e "\n======\nPopulating /mnt/etc/nixos \n======\n\n"

mv * /mnt/etc/nixos
cd /mnt/etc/nixos

echo -e "\n======\nInstalling NixOS\n======\n\n"

mkdir -p /mnt/tmp
TMPDIR=/mnt/tmp nixos-install --flake '.#nixos'

# sudo reboot

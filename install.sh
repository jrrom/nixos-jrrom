#!/usr/bin/env bash

sudo nix \
  --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- \
  --mode disko ./disko-config.nix

sudo nixos-generate-config --no-filesystems --root /mnt

sudo nixos-install --root /mnt --flake '.#nixos'

# sudo reboot

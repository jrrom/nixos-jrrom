#!/usr/bin/env bash

read -P "Enter your disk\t:\t" disk

sudo nix run 'github:nix-community/disko/latest#disko-install' -- \
     --write-efi-boot-entries \
     --flake '.#nixos' \
     --disk main "$disk"

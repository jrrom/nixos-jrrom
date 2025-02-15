{ pkgs, ... }:

{
  programs.adb = {
    enable = true;
  };

  services.udev.packages = with pkgs; [
    libmtp
  ];

  services.gvfs.enable = true;
}

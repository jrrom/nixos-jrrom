{ pkgs, ... }:

{
  programs.adb = {
    enable = true;
  };

  services.udev.packages = with pkgs; [
    libmtp.out
  ];

  services.gvfs.enable = true;
}

{ pkgs, ... }:

{
  services.gammastep = {
    enable = true;
    tray = true;
    latitude = "13.08";
    longitude = "80.27";
  };
}
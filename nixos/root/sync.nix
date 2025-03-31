{ pkgs, lib, information, ... }:

{
  services.syncthing = {
    enable = true;
    user = information.hostName;
    dataDir = "/home/${information.hostName}/.config/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    };
  };
}

{ pkgs, lib, ... }:

{
  services.syncthing = {
    enable = true;
    user = "jrrom";
    dataDir = "/home/jrrom/.config/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      devices = {
        "oneplus" = { id = "L5XWWMJ-JBLN7GE-QAGXFOO-LSQ5M6Q-SYZKCH2-DGZ4UQS-SJ7YFCP-LE5UHA5"; };
      };
      folders = {
        "Sync" = {
          path = "~/Sync";
          devices = [ "oneplus" ];
        };
      };
    };
  };
}

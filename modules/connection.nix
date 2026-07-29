# Bluetooth and Networking
{ inputs, ... }: {
  flake.nixosModules.connection = { pkgs, ... }: {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    networking = {
      hostName = "jrrom";
      hostId = "ede53986";
      networkmanager.enable = true;
      networkmanager.wifi.powersave = true;
      firewall.enable = true;
    };
  };
}

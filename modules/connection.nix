# Bluetooth, Networking, Pipewire
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

    # Pipewire
    security.rtkit.enable = true; # Realtime scheduler
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

  };
}

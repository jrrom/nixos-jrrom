{ pkgs, ... }:

{
  services.tlp = {
    enable = true;
  };
  
  services.thermald.enable = true;

  services.fwupd.enable = true;

  # Heard this is good from word of mouth
  services.irqbalance.enable = true;

  # Speed up SSD, allows OS to inform SSD which blocks are no longer in use
  services.fstrim.enable = true;
}

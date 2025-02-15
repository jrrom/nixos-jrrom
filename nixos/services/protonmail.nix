{ pkgs, ... }:

{
  services.protonmail-bridge = {
    enable = true;
    path = with pkgs; [
      pass
      gnome-keyring
    ];
  };

  services.gnome.gnome-keyring.enable = true;

  services.passSecretService = {
    enable = true;
  };
}

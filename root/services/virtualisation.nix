{ pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    # networkSocket.enable = true;
  };
}

{ inputs, ... }: {
  flake.nixosModules.input = { pkgs, ... }: {
    console = {
      useXkbConfig = true; # use xkb.options in tty.
    };
    
    services.libinput.enable = true; # Touchpad
    
    services.xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "compose:ralt";
    };
  };
}

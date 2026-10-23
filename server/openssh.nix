{ inputs, ... }: {
  flake.nixosModules.openssh = { pkgs, ... }: {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;        # keys only
        PermitRootLogin = "prohibit-password"; # root only via key
      };
    };
  };
}

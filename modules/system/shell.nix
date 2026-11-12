{ inputs, config, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
      set -g fish_greeting

      direnv hook fish | source  
    '';
      generateCompletions = true;
      shellAliases = {
        z    = "zoxide";
        bb   = "busybox";
        terraform-ls = "tofu-ls";
      };
    };

    # Environments
    services.tailscale = {
      enable =  true;
    };

    programs.direnv = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.bat = {
      enable = true;
    };

    programs.git = {
      enable = true;
      config = {
        user = {
          email = config.constants.admin.gitEmail;
          name  = config.constants.admin.gitName;
        };
      };
    };
  };
}

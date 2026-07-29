{ inputs, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
      set -g fish_greeting

      direnv hook fish | source  
    '';
      generateCompletions = true;
    };

    # Environments
    
    environment.systemPackages = [ pkgs.devenv ];

    programs.direnv = {
      enable = true;
      enableFishIntegration = true;
    };

  };
}

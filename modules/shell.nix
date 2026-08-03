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
    
    environment.systemPackages = with pkgs; [
      # Env
      devenv

      # Data wrangling
      miller
      jq
      xh

      # Status
      btop
      dust
      procs
      tldr

      # General
      bat
      fd
      fzf
      ripgrep
      zoxide

      # Misc
      yad
    ] ++ [
      # Scripting language for scripts
      (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
        numpy
        pandas
        tkinter
        xlrd
      ]))
      ty
    ];

    programs.direnv = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}

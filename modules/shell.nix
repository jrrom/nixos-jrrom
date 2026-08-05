{ inputs, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
      set -g fish_greeting

      direnv hook fish | source  
    '';
      generateCompletions = true;
      shellAliases = {
        cat  = "bat";
        diff = "delta";
        find = "fd";
        ps   = "procs";
        z    = "zoxide";
      };
    };

    # Environments
    
    environment.systemPackages = with pkgs; [
      # Env
      devenv

      # Data wrangling
      miller # structured data editing
      jq # json
      xh # curl replacement

      # Status
      btop # top replacement
      dust # disk usage
      procs # ps replacement, see processes
      tldr # short man

      # General
      delta # better diffs
      fd # better find
      ouch # compression and decompression
      ripgrep # better grep
      zoxide # better cd

      # Languages (other than Python)
      d2 # Diagrams
      
      # Misc
      yad
    ] ++ [
      # Scripting language for scripts
      (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
        numpy
        pandas
        tkinter
        xlrd # .xls old format
      ]))
      basedpyright
    ];

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
  };
}

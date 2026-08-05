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
      btop # top replacement
      curl
      delta # better diffs
      dust # disk usage
      fd # better find
      ffmpeg
      jq
      jq # json
      man-pages
      man-pages-posix
      ncgopher
      ouch # compression and decompression
      procs # ps replacement, see processes
      ripgrep # better grep
      texliveFull
      tldr # short man
      tree
      unrar
      unrtf
      unzip
      wget
      wl-clipboard
      xdg-ninja
      xh # curl replacement
      yad
      zoxide # better cd

      # Cloud stuff
      oci-cli
      gh
      exercism # for practice and stuff
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

    programs.git = {
      enable = true;
      config = {
        user = {
          email = "77691121+jrrom@users.noreply.github.com";
          name = "jrrom";
        };
      };
    };
  };
}

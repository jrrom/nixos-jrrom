{inputs, ...}: {
  flake.homeModules.cc = { pkgs, cosmicLib, ... }: {
    programs.claude-code = {
      enable = true;
      package = pkgs.claude-code;
      settings = {
        includeCoAuthoredBy = false;   # legacy key, kept for older CC versions
        attribution = {
          commit = "";
          pr = "";
        };
        # permissions = {

        # };
      };
    };
  };
}

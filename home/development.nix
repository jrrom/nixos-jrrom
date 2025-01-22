{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Basic
    clang
    
    # Developer Environments
    devenv    

    # LSPS
    basedpyright
    nixd
  ];
}

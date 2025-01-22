{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Basic
    clang

    # Tools
    gdb
    
    # Developer Environments
    devenv    

    # LSPS
    basedpyright
    nixd
  ];
}

{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    # Programming Languages
    go
    luajit

    # Development Kits
    clang-tools
    
    # Tools
    gdb
    gnumake
    shellcheck
    
    # LSPS
    vscode-langservers-extracted
    gopls
    lua-language-server
    basedpyright
    bash-language-server
    nixd
  ];
}

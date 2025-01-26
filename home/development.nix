{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    # Programming Languages
    clang
    go
    luajit
    python313

    # Development Kits
    clang-tools
    
    # Tools
    gdb
    gnumake
    shellcheck
    
    # Developer Environments
    devenv
    podman-tui
    distrobox

    # LSPS
    vscode-langservers-extracted
    gopls
    lua-language-server
    basedpyright
    bash-language-server
    nixd
  ];
}

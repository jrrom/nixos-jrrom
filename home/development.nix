{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Programming Languages
    clang
    libgcc
    go
    luajit

    # Development Kits
    clang-tools
    
    # Tools
    gdb
    gnumake
    shellcheck
    
    # Developer Environments
    devenv    

    # LSPS
    vscode-langservers-extracted
    gopls
    lua-language-server
    basedpyright
    bash-language-server
    nixd
  ];
}

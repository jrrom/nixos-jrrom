{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    clang
    clang-tools
    devenv
    epstool
    ghostscript
    graphviz
    nixd
    nixfmt
    nodejs
    plantuml-c4
    quickjs
    texlab
    texliveFull
    miller
    hledger
    opentofu
    tofu-ls
    yaml-language-server
    vscode-langservers-extracted
  ];
}

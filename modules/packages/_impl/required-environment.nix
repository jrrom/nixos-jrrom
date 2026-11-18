{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Misc
    devenv
    epstool
    hledger
    miller

    # C
    clang
    clang-tools
    
    # Documents
    plantuml-c4
    ghostscript
    graphviz
    texlab
    texliveFull
    typst
    tinymist

    # NixOS
    nixd
    nixfmt

    # JavaScript
    nodejs
    quickjs

    # Terraform
    opentofu
    tofu-ls

    # Related
    yaml-language-server
    vscode-langservers-extracted

    # Python
    python3
    basedpyright
  ];
}

{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    alegreya
    alegreya-sans
    fira-mono
    fira-sans
    libertinus
    maple-mono.truetype
    nerd-fonts.symbols-only
    noto-fonts
    source-sans
    source-serif
  ];
}

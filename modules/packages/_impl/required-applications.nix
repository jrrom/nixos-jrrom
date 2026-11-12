{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    aseprite
    blender
    foliate
    godot
    jetbrains.datagrip
    jetbrains.idea
    keepassxc
    libreoffice
    logisim-evolution
    rhythmbox
    simple-scan
    tenacity
    vlc
    zathura
    zulip

    (steam.override {
      extraPkgs = p: with p; [ libGLU ];
    }).run
  ];
}

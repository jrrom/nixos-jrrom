{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    aseprite
    blender
    strawberry
    foliate
    godot
    jetbrains.datagrip
    jetbrains.idea
    keepassxc
    libreoffice
    logisim-evolution
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

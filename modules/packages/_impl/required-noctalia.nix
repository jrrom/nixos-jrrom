{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gruvbox-plus-icons
    qt6Packages.qt6ct
  ];
}

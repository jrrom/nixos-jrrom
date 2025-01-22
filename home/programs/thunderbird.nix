{ pkgs, ... }:

{
  programs.thunderbird = {
    profiles.jrrom.isDefault = true;
    enable = true;
    profiles = {
      jrrom = {
        isDefault = true;
      };
    };
  };
}

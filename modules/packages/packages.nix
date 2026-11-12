{ ... }:
{
  flake.nixosModules.packages = {
    imports = [
      ./_impl/required-applications.nix
      ./_impl/required-emacs.nix
      ./_impl/required-environment.nix
      ./_impl/required-fonts.nix
      ./_impl/required-noctalia.nix
      ./_impl/required-shell.nix
    ];
  };
}

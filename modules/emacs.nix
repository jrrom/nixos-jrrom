# Emacs
{ inputs, ... }: {
  flake.nixosModules.emacs = { pkgs, ... }: {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    environment.systemPackages = with pkgs; [
      pkgs.emacsWithPackagesFromUsePackage {
        package = pkgs.emacs-pgtk;
        config = ../parts/emacs.org;
        defaultInitFile = false;
        alwaysTangle = true;
        extraEmacsPackages = epkgs: [
          (epkgs.treesit-grammars.with-all-grammars)
        ];
      }
    ];
  };
}

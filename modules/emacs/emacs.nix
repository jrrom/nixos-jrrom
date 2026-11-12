{ inputs, config, lib, ... }:

let
  flatten = set: lib.concatMapAttrs (n: v:
    if builtins.isAttrs v
    then lib.mapAttrs' (k: val: { name = "${n}.${k}"; value = val; }) (flatten v)
    else { ${n} = v; }
  ) set;

  substitutions = lib.mapAttrsToList (name: value: {
    from = "{{${name}}}"; to = "${toString value}";
  }) (flatten { config = { constants = config.constants; }; });

  renderedSource =
    (builtins.replaceStrings
      (map (s: s.from) substitutions)
      (map (s: s.to)   substitutions)
      (builtins.readFile ./config.org));
    
in
{
  flake.nixosModules.emacs = { pkgs, ... }: {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];
    environment.systemPackages = [( 
      pkgs.emacsWithPackagesFromUsePackage {
        package = pkgs.emacs;
        config = pkgs.writeText "config.org" renderedSource;
        defaultInitFile = true;
        alwaysTangle = true;
        extraEmacsPackages = epkgs: [
          (epkgs.treesit-grammars.with-all-grammars)
        ];
      }
    )];

    environment.sessionVariables = {
      EDITOR = "emacs";
      VISUAL = "emacs";
    };

    programs.nano.enable = false;
  };
}

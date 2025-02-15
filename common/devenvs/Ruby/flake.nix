{
  description = "jrrom's Ruby flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils?ref=main";
  };

  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      lib  = pkgs.lib;
    in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            ruby_3_4
          ];
          
          buildInputs = with pkgs; [
            libyaml
          ];
          
          shellHook = ''
            bundle config set --local path vendor/bundle
            export PATH="$PWD/bin:$PATH"
          '';
        };
      });
}

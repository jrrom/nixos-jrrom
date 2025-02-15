{
  description = "jrrom's Python flake";

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
            (python313.withPackages (ps: with ps; [pip]))
            python313Packages.venvShellHook
          ];
          
          buildInputs = with pkgs; [
            zlib
            stdenv.cc.cc.lib
          ];
          
          # nativeBuildInputs = [ pkgs.makeWrapper ];
          
          venvDir = ".venv";
          postShellHook = ''
            unset SOURCE_DATE_EPOCH
            export LD_LIBRARY_PATH=${lib.makeLibraryPath [ pkgs.stdenv.cc.cc pkgs.zlib ]}
          '';
        };
      });
}

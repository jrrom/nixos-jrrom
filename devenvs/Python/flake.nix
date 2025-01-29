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
          buildInputs = with pkgs; [
            zlib
            stdenv.cc.cc.lib
          ];
          venvDir = ".venv";
          packages =
            (with pkgs; [ python313]) ++ (with pkgs.python313Packages; [
              pip
              venvShellHook
            ]);

          postShellHook = ''
            unset SOURCE_DATE_EPOCH
            export LD_LIBRARY_PATH=${lib.makeLibraryPath [ pkgs.stdenv.cc.cc pkgs.zlib ]}
          '';
        };
      });
}

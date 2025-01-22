3 year old thread lol, but I encountered this issue and have a workaround. I used flakes for this example.

The flake:

{
  description = "PyTorch flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; config.cudaSupport = true; };
      venvDir = "venv";
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          virtualenv
          python310
          python310Packages.pytorch-bin
          python310Packages.pandas
          python310Packages.numpy
        ];
      };
  };
}

I then created a wrapper script to call python (include the directory to your flake.nix), lets call it nix-python.sh:

#!/bin/sh
exec nix develop /path/to/your/flake --command python "$@"

Also need to run

chmod +x nix-python.sh

Finally, add nix-python.sh as a system interpreter to your Pycharm, and things seem to be working for me.


{ inputs, ... }: {
  flake.nixosModules.kDrive = { pkgs, ... }: {
    imports = [
      inputs.kDrive.nixosModules.default
    ];
    
    programs.kDrive.enable = true;
  };
}

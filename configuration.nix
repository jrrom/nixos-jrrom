{ config, lib, pkgs, user, ... }:

{
  imports =
    [
      # Hardware
      ./hardware-configuration.nix
      ./disko-config.nix
    ];

  # Nix
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" "pipe-operators"];
    cores = 2;
    # Determinate Systems
    trusted-substituters = [ "https://install.determinate.systems" ];
    trusted-public-keys  = [ "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM=" ];
  };
  nixpkgs.config.allowUnfree = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;
  
  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # System
  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_IN";
    extraLocales = "en_US.UTF-8";
  };
  
  # Networking
  networking.hostName = "jrrom"; # Define your hostname.
  networking.hostId = "ede53986";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;
  networking.firewall.enable = true;

  # Pipewire
  security.rtkit.enable = true; # Realtime scheduler
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Input
  services.libinput.enable = true; # Touchpad
  
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # see https://nixos.org/manual/nixos/stable/#sec-upgrading
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  system.stateVersion = "25.05";
}
  

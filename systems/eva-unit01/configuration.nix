{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  # Custom modules
  modules = {
    desktops = {
      hyprland.enable = true;
      #plasma.enable = true;
      #sway.enable = true;
    };
    drivers = {
      amd-graphics.enable = true;
      pipewire.enable = true;
    };
    programs = {
      gamescope.enable = true;
      steam.enable = true;
      thunar.enable = true;
    };
    security = {
      gnome-keyring.enable = true;
    };
    services = {
      blueman.enable = true;
    };
  };

  # Nixpkgs config
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.scripts
      outputs.overlays.stable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  # Bootloader config
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "eva-unit01";
    # Network management GUI
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # Open ports
      # 25565 is for MC servers
      allowedTCPPorts = [25565];
      allowedUDPPorts = [25565];
    };
  };

  # Remove need to type in password for sudo commands
  security.sudo.extraRules = [
    {
      users = ["stormytuna"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  # NixOS settings
  nix = {
    settings = {
      experimental-features = "nix-command flakes"; # Enable flakes
      trusted-users = ["root" "@wheel"]; # Allow user to use substiturers
    };
    nixPath = ["nixpkgs=${inputs.nixpkgs}"]; # nixd expects this
    # Enable automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  users.users.stormytuna = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.nushell;
  };

  # Internationalisation stuff
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure tty keymap
  console.keyMap = "us";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

{ pkgs, systemSettings, userSettings, ... }:

{
  imports = [
    (./. + "/wm/${userSettings.wm}.nix") # Selected window manager
    ./apps/gaming.nix # Steam + GameMode config
    ./hardware-configuration.nix # Hardware config
    ./hardware/audio.nix # Audio config
    ./hardware/bluetooth.nix # Bluetooth config
    ./hardware/video.nix # GPU drivers 
  ];

  # Configure bootloader
  # Uses systemd-boot if uefi, grub otherwise
  boot.loader.systemd-boot.enable = systemSettings.bootMode == "uefi";
  boot.loader.efi.canTouchEfiVariables = systemSettings.bootMode == "uefi";
  boot.loader.efi.efiSysMountPoint = systemSettings.bootMountPath; # Does nothing if we're using grub
  boot.loader.grub.enable = systemSettings.bootMode != "uefi";
  boot.loader.grub.device = systemSettings.grubDevice; # Does nothing if we're using uefi

  # Remove need to type in password for sudo commands
  security.sudo.extraRules = [
    {
      users = [ "stormytuna" ];
      commands = [ 
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Networking
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true; # Easier to use than alternative

  # Select internationalisation properties.
  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # Configure tty keymap
  console.keyMap = systemSettings.consoleKeymap;

  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel" # Enable `sudo`
    ];
    shell = pkgs.zsh;
  };

  # Delete old images
  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };

  # We love being POSIX compliant
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ]; # Required for zsh completions for system packages

  # System packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    btop
    fzf
    fd
    unp
    unrar
    unzip
    ripgrep
    imagemagick
    tldr
    bitwarden

    # TODO: Find a place for these!
    dotnet-sdk_8 # TODO: Need multiple SDKs
    omnisharp-roslyn
    mono
    msbuild
  ];

  # Allow unfree
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Leave this unchanged for compatibility purposes
  system.stateVersion = "23.11";
}


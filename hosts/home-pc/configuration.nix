{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./home.nix
    ./hardware-configuration.nix
    ../../modules
  ];

  modules = {
    apps = {
      enable = true;
      discord.enable = true;
      #firefox.enable = true;
      gaming.enable = true;
      spotify.enable = true;
      thunar.enable = true;
      vesktop.enable = true;
      zen.enable = true;
    };
    desktop = {
      #gnome.enable = true;
      hyprland.enable = true;
    };
    dev = {
      enable = true;
      csharp.enable = true;
      git.enable = true;
      #java.enable = true;
      neovim.enable = true;
      vscode.enable = true;
    };
    hardware = {
      bluetooth.enable = true;
      graphics.enable = true;
      networking.enable = true;
      networking.hostname = "eva-unit01";
      pipewire.enable = true;
    };
    security = {
      gnome-keyring.enable = true;
    };
    services = {
      collectNixGarbage = {
        #enable = true;
      };
    };
    shell = {
      enable = true;
      alacritty.enable = true;
      kitty.enable = true;
      starship.enable = true;
      zsh.enable = true;
      zsh.makeDefault = true;
    };
    stylix = {
      enable = true;
      theming = {
        wallpaper = /. + "${config.users.users.stormytuna.home}/Pictures/Wallpapers/frieren-tree.png";
        scheme = "catppuccin-mocha";
        polarity = "dark";
      };
      icons = {
        package = pkgs.kora-icon-theme;
        name = "kora";
      };
      fonts = {
        serif = {
          name = "Crimson";
          package = pkgs.crimson;
        };
        sansSerif = {
          name = "Roboto";
          package = pkgs.roboto;
        };
        monospace = {
          name = "MonaspiceKr Nerd Font";
          package = pkgs.nerdfonts.override {fonts = ["Monaspace"];};
        };
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-emoji;
        };
      };
      cursor = {
        # bibata-cursors - Bibata-(Modern|Original)-(Amber|Classic|Ice)
        # phinger-cursors - phinger-cursors-(dark|light)
        # oreo-cursors-plus
        # volantes-cursors - volantes_cursors volantes_light_cursors
        # afterglow-cursors-recolored
        package = pkgs.afterglow-cursors-recolored;
        name = "Afterglow-Recolored-Original-joris4";
        size = 24;
      };
    };
  };

  # Configure bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-generations +10";
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

  # Select internationalisation properties.
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

  # User account
  users.users.stormytuna = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable `sudo`
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Leave this unchanged for compatibility purposes
  system.stateVersion = "23.11";
}

{
  description = "flakeytuna";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    stylix.url = "github:danth/stylix";
  };

  outputs = inputs @ { self, ... }:
    let
      # System settings
      systemSettings = {
        systemArch = "x86_64-linux";
        hostname = "eva-unit01";
        timezone = "Europe/London";
        locale = "en_GB.UTF-8";
        keymap = "us";
        consoleKeymap = "us"; # console.keyMap expects "uk", not "gb"... yay
        bootMode = "uefi"; # uefi OR bios
        bootMountPath = "/boot"; # Mount path for efi boot partition, only used for uefi boot mode
        grubDevice = ""; # Device identifier for grub, only used for bios boot mode
      };

      # User settings
      userSettings = rec {
        username = "stormytuna";
        email = "stormytuna@outlook.com";
        nixosConfigDir = "/home/${username}/.nixos";
        dotfilesDir = "/home/${username}/.config";

        # Software
        wm = "hyprland";
        wmType = if (wm == "hyprland") then "wayland" else "x11";
        browser = "firefox";
        terminal = "kitty";
        editor = "nvim";
        spawnEditor = "exec " + terminal + " -e " + editor;

        # Modular configs
        waybar.modules = "minimal";
        hyprland.visuals = "sharp";

        # Theming
        colourScheme = "catppuccin-mocha";
        wallpaper = "bridget";
        polarity = "dark";

        # Fonts - directly passed to stylix, see ./home/style/stylix.nix
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
            name = "Monospice Kr Nerd Font";
            package = (pkgs.nerdfonts.override { fonts = [ "Monaspace" ]; });
          };
          emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts-emoji;
          };
        };
        extraFontPackages = [];

        # Cursor
        cursorSettings = { # Set to `home.pointerCursor`, see that for option info
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          # Bibata-(Modern|Original)-(Amber|Classic|Ice)
          size = 24;
        };
      };

      pkgs = import inputs.nixpkgs {
        system = systemSettings.systemArch;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
          packageOverrides = pkgs: {
            nur = inputs.nur;
            inherit pkgs;
          };
        };
      };

      pkgs-stable = import inputs.nixpkgs-stable {
        system = systemSettings.systemArch;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
        };
      };
    in
  {
    # TODO: Cleanup, I don't like having to use inputs everywhere
    nixosConfigurations.${systemSettings.hostname} = inputs.nixpkgs.lib.nixosSystem {
      system = systemSettings.systemArch;
      modules = [ 
        ./system/configuration.nix 
        inputs.chaotic.nixosModules.default 
      ];
      specialArgs = {
        inherit pkgs-stable;
        inherit systemSettings;
        inherit userSettings;
      };
    };

    homeConfigurations.${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/home.nix
          inputs.stylix.homeManagerModules.stylix
        ];
        extraSpecialArgs = {
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
          inherit self;
        };
    };
  };
}

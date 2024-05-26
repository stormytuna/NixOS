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
  };

  outputs = inputs @ { self, ... }:
    let
      # System settings
      systemSettings = {
        systemArch = "x86_64-linux";
        hostname = "eva-unit01";
        timezone = "Europe/London";
        locale = "en_GB.UTF-8";
        keymap = "gb";
        consoleKeymap = "uk"; # console.keyMap expects "uk", not "gb"... yay
        bootMode = "uefi"; # uefi OR bios
        bootMountPath = "/boot"; # Mount path for efi boot partition, only used for uefi boot mode
        grubDevice = ""; # Device identifier for grub, only used for bios boot mode
      };

      # User settings
      userSettings = rec {
        username = "stormytuna";
        email = "stormytuna@outlook.com";
        dotfilesDir = "~/.nixos";

        # Modular configs
        waybar.modules = "minimal";

        # Software
        wm = "hyprland";
        wmType = if (wm == "hyprland") then "wayland" else "x11";
        browser = "firefox";
        terminal = "kitty";
        editor = "nvim";
        spawnEditor = "exec " + terminal + " -e " + editor;

        # Fonts
        serifFonts = [ "Crimson" ];
        sansSerifFonts = [ "Roboto" ];
        monospaceFonts = [ "Monospice Ne Nerd Font "];
        fontPackages = with pkgs; [
          (nerdfonts.override { fonts = [ "Monaspace" ]; })
          crimson
          roboto
        ];

        # Cursor
        cursorSettings = { # Set to `home.pointerCursor`, see that for option info
          package = pkgs.bibata-cursors;
          name = "Bibata-Original-Ice";
          size = 24;
        };
      };

      pkgs = import inputs.nixpkgs {
        system = systemSettings.systemArch;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
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
    nixosConfigurations.${systemSettings.hostname} = inputs.nixpkgs.lib.nixosSystem {
      system = systemSettings.systemArch;
      modules = [ ./system/configuration.nix inputs.chaotic.nixosModules.default ];
      specialArgs = {
        inherit pkgs-stable;
        inherit systemSettings;
        inherit userSettings;
      };
    };

    homeConfigurations.${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/home.nix ];
        extraSpecialArgs = {
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
        };
    };
  };
}

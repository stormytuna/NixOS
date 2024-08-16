{
  description = "flakeytuna";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur.url = "github:nix-community/NUR";

    stylix.url = "github:danth/stylix";
  };

  outputs = inputs @ {self, ...}: let
    # System settings
    systemSettings = {
      systemArch = "x86_64-linux";
      hostname = "eva-unit01";
      timezone = "Europe/London";
      locale = "en_GB.UTF-8";
      keymap = "us";
      consoleKeymap = "us"; # console expects a different string for some keymaps
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
      browser = "firefox";
      terminal = "kitty";
      editor = "nvim";
      spawnTerm = "kitty"; # Useful for adding params to every terminal window

      # Modular configs # TODO: Rewrite these
      waybar.modules = "informational";
      hyprland.visuals = "sharp";

      wmType =
        if (wm == "hyprland")
        then "wayland"
        else "x11"; # TODO: This isnt even true lol

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
          name = "MonaspiceKr Nerd Font";
          package = pkgs.nerdfonts.override {fonts = ["Monaspace"];};
        };
        emoji = {
          name = "Noto Color Emoji";
          package = pkgs.noto-fonts-emoji;
        };
      };
      extraFontPackages = [];

      # Cursor
      cursorSettings = {
        # Set to `home.pointerCursor`, see that for option info
        # bibata-cursors - Bibata-(Modern|Original)-(Amber|Classic|Ice)
        # phinger-cursors - phinger-cursors-(dark|light)
        # oreo-cursors-plus
        # volantes-cursors - volantes_cursors volantes_light_cursors
        package = pkgs.volantes-cursors;
        name = "volantes_cursors";
        size = 24;
      };
    };

    pkgs = import inputs.nixpkgs {
      system = systemSettings.systemArch;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
        permttedInsecurePackages = [
          "python-2.7.18.8"
        ];
        packageOverrides = pkgs: {
          nur = inputs.nur;
          inherit pkgs;
        };
      };
      overlays = [inputs.nix-vscode-extensions.overlays.default];
    };

    pkgs-stable = import inputs.nixpkgs-stable {
      system = systemSettings.systemArch;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  in {
    nixosConfigurations.${systemSettings.hostname} = inputs.nixpkgs.lib.nixosSystem {
      system = systemSettings.systemArch;
      modules = [
        ./configuration.nix
        inputs.chaotic.nixosModules.default
        inputs.nur.nixosModules.nur
        inputs.stylix.nixosModules.stylix
      ];
      specialArgs = {
        inherit pkgs-stable;
        inherit systemSettings;
        inherit userSettings;
      };
    };
  };
}

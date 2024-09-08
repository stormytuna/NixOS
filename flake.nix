{
  description = "flakeytuna";

  nixConfig = {
    extra-substituters = [
      "https://cache.m7.rs"
      "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

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

    zen-browser.url = "github:MarceColl/zen-browser-flake"; # TODO: Replace when https://github.com/NixOS/nixpkgs/issues/327982 is closed
  };

  outputs = inputs @ {self, ...}: let
    pkgs-stable = import inputs.nixpkgs-stable {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  in {
    nixosConfigurations.eva-unit01 = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/home-pc/configuration.nix
        inputs.chaotic.nixosModules.default
        inputs.nur.nixosModules.nur
        inputs.stylix.nixosModules.stylix
      ];
      specialArgs = {
        inherit pkgs-stable;
        zen-browser = inputs.zen-browser;
        vscode-marketplace = inputs.nix-vscode-extensions.extensions."x86_64-linux".vscode-marketplace;
      };
    };
  };
}

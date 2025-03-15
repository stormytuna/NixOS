{
  description = "flakeytuna";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://cosmic.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=master";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # TODO: Look into what packages chaotic provides
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur.url = "github:nix-community/NUR";

    stylix.url = "github:danth/stylix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake"; # TODO: Add to own packages

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Custom packages, accessible from `nix build`, `nix shell`, etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Formatter, accessible from `nix fmt`
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Overlays, for custom packages and modifications
    overlays = import ./overlays {inherit inputs;};

    # TODO: Generify these
    # Home PC System
    nixosConfigurations.eva-unit01 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./systems/eva-unit01/configuration.nix
        #inputs.stylix.nixosModules.stylix
        inputs.chaotic.nixosModules.default
        inputs.nixos-cosmic.nixosModules.default
      ];
      specialArgs = {
        inherit inputs outputs;
      };
    };

    # Main user
    homeConfigurations.stormytuna = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./users/stormytuna/home.nix
        inputs.stylix.homeManagerModules.stylix
        inputs.nvf.homeManagerModules.default
      ];
      extraSpecialArgs = {inherit inputs outputs;};
    };
  };
}

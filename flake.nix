{
  description = "flakeytuna";

  nixConfig = {
    extra-trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://cosmic.cachix.org/"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=master";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=master";

    #home-manager.url = "github:nix-community/home-manager/master";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    #stylix.url = "github:danth/stylix";
    stylix.url = "github:danth/stylix/release-25.05";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
    ];
    forEachSystem = nixpkgs.lib.genAttrs systems;
  in {
    packages = forEachSystem (system: import ./pkgs nixpkgs.legacyPackages.${system});

    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      "eva-unit-01" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/eva-unit-01
          inputs.stylix.nixosModules.stylix
          inputs.chaotic.nixosModules.default
          inputs.nixos-cosmic.nixosModules.default
        ];
      };
    };

    homeConfigurations = {
      "stormytuna" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home/stormytuna.nix
          inputs.stylix.homeModules.stylix
          inputs.nvf.homeManagerModules.default
          inputs.spicetify-nix.homeManagerModules.default
        ];
      };
    };
  };
}

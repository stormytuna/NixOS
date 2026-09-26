{
  description = "flakeytuna";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-26.05";

    foundry-vtt.url = "github:nix-foundryvtt/nix-foundryvtt";
    #foundry-vtt.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    ...
  } @ inputs: {
    nixosConfigurations = {
      eva-unit-01 = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/eva-unit-01/configuration.nix
          inputs.foundry-vtt.nixosModules.foundryvtt
          inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.spicetify-nix.nixosModules.default
        ];
        specialArgs = {
          inherit inputs;
          pkgs-stable = import nixpkgs-stable { 
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
      };
      eva-unit-02 = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/eva-unit-02/configuration.nix
          inputs.nix-flatpak.nixosModules.nix-flatpak
        ];
        specialArgs = {
          inherit inputs;
          pkgs-stable = import nixpkgs-stable { 
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
      };
    };
  };
}

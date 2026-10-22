{
  description = "flakeytuna";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs?ref=master";

    foundry-vtt.url = "github:nix-foundryvtt/nix-foundryvtt";
    #foundry-vtt.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-master,
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
          pkgs-unstable = import nixpkgs-unstable { 
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          pkgs-master = import nixpkgs-master { 
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
          pkgs-unstable = import nixpkgs-unstable { 
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          pkgs-master = import nixpkgs-master { 
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
      };
    };
  };
}

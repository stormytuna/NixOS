{
  description = "flakeytuna";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    # TODO: Pass unstable packages and actually use them
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    foundry-vtt.url = "github:reckenrode/nix-foundryvtt";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
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
        specialArgs = {inherit inputs;};
      };
    };
  };
}

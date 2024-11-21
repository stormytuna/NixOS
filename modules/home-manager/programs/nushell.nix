{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.nushell;
  nomRedirect = "out+err>| ${pkgs.nix-output-monitor}/bin/nom";
in {
  options.modules.programs.nushell = {
    enable = lib.mkEnableOption "Data-based shell with modern design principles";
    makeDefault = lib.mkEnableOption "Make Nushell the user's default shell";
  };

  config = lib.mkIf cfg.enable {
    programs.nushell = {
      enable = true;

      configFile.text = ''
        $env.config = {
          show_banner: false
        }
      '';

      # Using extraConfig to insert aliases at end of config
      # shellAliases option was reordering aliases
      extraConfig = ''
        # NixOS update stuff
        def ups [] { sudo nixos-rebuild switch --flake ~/.nixos ${nomRedirect} }
        def uph [] { home-manager switch --flake ~/.nixos ${nomRedirect} }
        def upa [] { ups; uph }
        def upf [] { sudo nix flake update --flake ~/.nixos; upa }

        alias cl = clear

        # git

        alias qvf = nvim ~/.nixos
      '';
    };
  };
}

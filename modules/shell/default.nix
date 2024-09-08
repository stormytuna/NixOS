{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    <home-manager/nixos>
    ./alacritty.nix
    ./kitty.nix
    ./starship.nix
    ./zsh.nix
  ];

  options = {
    modules.shell.enable = lib.mkEnableOption "Enables various terminal programs";
  };

  config = lib.mkIf config.modules.shell.enable {
    environment.systemPackages = with pkgs; [
      tldr
      fastfetch
      ripgrep
      imagemagick
      git
      fzf
      fd
      eza
      btop
      bat
      killall
      gettext # Utility for printing terminal colours
      unp
      unrar
      unzip
      gh
      (nix-output-monitor.overrideAttrs {
        patches = [../../patches/nix-output-monitor-icons.patch];
      })
      comma # Runs packages from wherever they are without needing to install properly
    ];

    # TODO: Move into own thing
    home-manager.users.stormytuna = {pkgs, ...}: {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      home.file.".config/fastfetch/config.jsonc".source = ./conf/fastfetch/fastfetch.jsonc;
    };
  };
}

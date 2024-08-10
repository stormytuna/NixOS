{ pkgs, pkgs-stable, ... }:

{
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
    nix-output-monitor
  ];

  home-manager.users.stormytuna = { pkgs, ... }:
  {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    home.file.".config/fastfetch/config.jsonc".source = ./conf/fastfetch/fastfetch.jsonc;
  };
}

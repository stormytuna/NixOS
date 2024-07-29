{ pkgs, pkgs-stable, ... }:

{
  environment.systemPackages = with pkgs; [
    tldr
    pkgs-stable.thefuck # Broken on unstable currently
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

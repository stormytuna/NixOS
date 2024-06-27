{ config, pkgs, systemSettings, userSettings, lib, ... }:

{
  imports = [
    # TODO: Create central user config for module importing and tweaking settings of modules
    # want to be able to change theme in one location and have everything update, etc
    (./. + "/shell/${userSettings.terminal}.nix") # Chosen terminal emulator
    (./. + "/shell/${userSettings.editor}.nix") # Chosen editor
    (./. + "/wm/${userSettings.wm}/${userSettings.wm}.nix") # Chosen window manager
    ./shell/shell.nix
    ./shell/starship.nix # Terminal prompt
    ./apps/gaming.nix # Gaming related stuff (MangoHud, Lutris, etc)
    ./apps/spotify.nix
    ./style/stylix.nix # Styling
  ];

  # Username and home directory
  home.username = "stormytuna";
  home.homeDirectory = "/home/stormytuna";

  # general packages
  home.packages = with pkgs; [
    firefox
    (discord.override {
      withVencord = true;
    })
    vesktop
    pavucontrol
    gh
    github-desktop
    jetbrains.rider
    avalonia-ilspy
    aseprite
  ];

  # TODO: Move somewhere else probably
  programs.git = {
    enable = true;
    userName = userSettings.username;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
      http.postBuffer = 157286400;
    };
  };

  # Dotfiles - most links are set where their config is declared
  home.file = {
  };

  # Shell session vars
  home.sessionVariables = {
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # let home manager install and manage itself
  programs.home-manager.enable = true;

  # Keep this for compatibility
  home.stateVersion = "23.11";
}

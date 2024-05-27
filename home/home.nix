{ config, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
    # TODO: Create central user config for module importing and tweaking settings of modules
    # want to be able to change theme in one location and have everything update, etc
    (./. + "/shell/${userSettings.terminal}.nix") # Chosen terminal emulator
    (./. + "/shell/${userSettings.editor}.nix") # Chosen editor
    (./. + "/wm/${userSettings.wm}/${userSettings.wm}.nix") # Chosen window manager
    ./shell/shell.nix
    ./app/gaming.nix # Gaming related stuff (MangoHud, Lutris, etc)
    ./style/stylix.nix # Styling
  ];

  # Username and home directory
  home.username = "stormytuna";
  home.homeDirectory = "/home/stormytuna";

  # Cursor theme
  #home.pointerCursor = userSettings.cursorSettings; # Unneeded as set by stylix

  # general packages
  home.packages = with pkgs; [
    firefox
    (discord.override {
      withVencord = true;
    })
    pavucontrol
    gh
    github-desktop
  ];

  # TODO: Move somewhere else probably
  programs.git = {
    enable = true;
    userName = userSettings.username;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "main";
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

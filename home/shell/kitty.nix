{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    theme = "Catppuccin-Mocha"; # TODO: Manage using flavours/nix-colours
    font = {
      name = "MonospiceNe Nerd Font";
      size = 14;
    };

    settings = {
      confirm_os_window_close = -1;
    };
  };
}

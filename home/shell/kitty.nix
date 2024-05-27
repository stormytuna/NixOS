{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    settings = {
      confirm_os_window_close = -1;
    };
  };
}

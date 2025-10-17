{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;

    extraConfig = ''
      confirm_os_window_close 2
      opacity 1

      cursor_trail 10
      cursor_trail_start_threshold 0
      cursor_trail_decay 0.01 0.05
    '';
  };
}

{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;

    extraConfig = ''
      confirm_os_window_close 2
      opacity 1
    '';
  };
}

{...}: {
  programs.kitty = {
    enable = true;

    extraConfig = ''
      confirm_os_window_close 2
    '';
  };
}

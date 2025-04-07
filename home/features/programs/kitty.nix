{...}: {
  programs.kitty = {
    enable = true;

    extraConfig = ''
      confirm_os_window_close 2
      notify_on_cmd_finish unfocused
    '';
  };
}

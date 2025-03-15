{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.kitty = {
    enable = lib.mkEnableOption "Fully featured terminal emulator";
  };

  config = lib.mkIf config.modules.programs.kitty.enable {
    programs.kitty = {
      enable = true;

      extraConfig = ''
        confirm_os_window_close 2
        notify_on_cmd_finish unfocused
      '';
    };
  };
}

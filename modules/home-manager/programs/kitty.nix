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

      settings = {
        confirm_os_window_close = 0; # Remove annoying "are you sure you want to close?" popup
        notify_on_cmd_finish = "unfocused";
      };
    };
  };
}

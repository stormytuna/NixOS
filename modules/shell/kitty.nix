{
  config,
  lib,
  ...
}: {
  imports = [<home-manager/nixos>];

  options = {
    modules.shell.kitty.enable = lib.mkEnableOption "Enables kitty and configuration";
  };

  config = lib.mkIf config.modules.shell.kitty.enable {
    home-manager.users.stormytuna.programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;

      settings = {
        confirm_os_window_close = 0;
        linux_display_backend = "x11";
      };
    };
  };
}

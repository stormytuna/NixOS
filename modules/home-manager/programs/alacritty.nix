{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.alacritty = {
    enable = lib.mkEnableOption "Lightweight terminal emulator";
  };

  config = lib.mkIf config.modules.programs.alacritty.enable {
    programs.alacritty = {
      enable = true;
      # TODO: configuration
    };
  };
}

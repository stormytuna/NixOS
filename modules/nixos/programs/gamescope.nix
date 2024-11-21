{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.gamescope = {
    enable = lib.mkEnableOption "Microcompositor tailored towards gaming";
  };

  config = lib.mkIf config.modules.programs.gamescope.enable {
    programs.gamescope = {
      enable = true;
      args = [
        "--output-width 3840"
        "--output-height 2160"
        "--nested-width 3840"
        "--nested-height 2160"
        "--force-grab-cursor"
        "--fullscreen"
      ];
    };
  };
}

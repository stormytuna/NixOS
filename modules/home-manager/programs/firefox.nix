# TODO: Finish this
{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.firefox = {
    enable = lib.mkEnableOption "FOSS web browser";
  };

  config = lib.mkIf config.modules.programs.firefox.enable {
    programs.firefox = {
      enable = true;
    };
  };
}

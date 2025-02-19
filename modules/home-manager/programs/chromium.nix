{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.chromium = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.modules.programs.chromium.enable {
    programs.chromium = {
      enable = true;
      # Unstable package blocks builds sometimes as it takes fuckin ages to build
      package = pkgs.stable.chromium;
    };
  };
}

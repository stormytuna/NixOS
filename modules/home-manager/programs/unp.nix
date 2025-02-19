{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.unp = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.modules.programs.unp.enable {
    home.packages = with pkgs; [
      unp
      unrar-free
    ];
  };
}

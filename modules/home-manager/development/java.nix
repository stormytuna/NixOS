{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.development.java = {
    enable = lib.mkEnableOption "Various tools for java development";
  };

  config = lib.mkIf config.modules.development.java.enable {
    programs.java.enable = true;
  };
}

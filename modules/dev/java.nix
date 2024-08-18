{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.dev.java.enable = lib.mkEnableOption "Enables packages for java development";
  };

  config = lib.mkIf config.modules.dev.java.enable {
    environment.systemPackages = with pkgs; [jdk22 jre8];
  };
}

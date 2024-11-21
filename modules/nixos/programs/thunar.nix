{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.thunar = {
    enable = lib.mkEnableOption "File browser";
  };

  config = lib.mkIf config.modules.programs.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman
        thunar-archive-plugin
      ];
    };

    programs.xfconf.enable = true; # Required for configs to be saved

    services.gvfs.enable = true; # Mount and trash functionality
    services.tumbler.enable = true; # Thumbnail support for images
  };
}

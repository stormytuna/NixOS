{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.sddm;
in {
  options = {
    modules.desktop.sddm.enable = lib.mkEnableOption "Enables sddm login manager";
    modules.desktop.sddm.wayland = lib.mkEnableOption "Makes sddm use wayland rather than x11";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = cfg.wayland;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm; # Required for catppuccin, not sure why
    };

    environment.systemPackages = [
      (pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        font = "${config.modules.stylix.fonts.monospace.name}";
        fontSize = "14";
        background = "${config.modules.stylix.theming.wallpaper}";
      })
    ];
  };
}

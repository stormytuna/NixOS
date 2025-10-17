{
  config,
  lib,
  ...
}: {
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = lib.mkForce "${config.stylix.fonts.monospace.name}:size=${toString (config.stylix.fonts.sizes.popups * 1.5)}";
        width = 50;
        lines = 12;
        horizontal-pad = 4;
        vertical-pad = 4;
        inner-pad = 4;
      };
      border = {
        width = 2;
        radius = 0;
      };
    };
  };
}

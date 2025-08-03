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
        width = 40;
        lines = 8;
        inner-pad = 2;
      };
    };
  };
}

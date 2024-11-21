{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.modules.programs.zen-browser = {
    enable = lib.mkEnableOption "Firefox based browser with privacy focus and some builtin plugins";
  };

  config = lib.mkIf config.modules.programs.zen-browser.enable {
    home.packages = [inputs.zen-browser.packages.${pkgs.system}.default];

    # TODO: More configs? declarative plugins?
  };
}

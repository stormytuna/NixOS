{
  pkgs,
  inputs,
  ...
}: let
  zen-desktop = "zen-twilight.desktop";
  #zen-desktop = "zen-beta.desktop";
in {
  home.packages = [inputs.zen-browser.packages.${pkgs.system}.beta];
}

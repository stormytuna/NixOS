{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
  ];

  # MangoHud, toggleable resource display
  programs.mangohud.enable = true;
  home.file.".config/MangoHud/MangoHud.conf".source = ./config/MangoHud.conf;
}

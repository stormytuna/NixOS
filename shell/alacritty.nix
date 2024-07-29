{ config, ... }:

let
  colours = config.lib.stylix.colors.withHashtag;
in
{
  imports = [ <home-manager/nixos> ];

  home-manager.users.stormytuna.programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
      };
      colors = {
        primary = {
          foreground = colours.base05;
          background = colours.base00;
          dim_foreground = colours.base04;
          bright_foreground = colours.base06;
        };
        search = {
          matches = { 
            foreground = colours.base06; 
            background = colours.base02;
          };
          focused_match = {
            foreground = colours.base07;
            background = colours.base02;
          };
        };
        normal = {
          black = colours.base00;
          red = colours.base08;
          green = colours.base0B;
          yellow = colours.base0A;
          blue = colours.base0D;
          magenta = colours.base0E;
          cyan = colours.base0C;
          white = colours.base05;
        };
      };
    };
  };
}

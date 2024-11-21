{
  config,
  lib,
  pkgs,
  ...
}: let
  colours = config.lib.stylix.colors.withHashtag;
in {
  options.modules.programs.starship = {
    enable = lib.mkEnableOption "Terminal status bar";
  };

  config = lib.mkIf config.modules.programs.starship.enable {
    programs.starship = {
      enable = true;

      settings = {
        add_newline = false;

        format = lib.concatStrings [
          "[ ](bg:${colours.base08})"
          "$username"
          "[](fg:${colours.base08} bg:${colours.base09})"
          "$directory"
          "[](fg:${colours.base09} bg:${colours.base0A})"
          "$git_branch"
          "$git_status"
          "[](fg:${colours.base0A} bg:${colours.base0B})"
          "$dotnet"
          "$golang"
          "$java"
          "$lua"
          "$rust"
          "$zig"
          "[](fg:${colours.base0B} bg:${colours.base0C})"
          "$cmd_duration"
          "[](fg:${colours.base0C} bg:${colours.base0D})"
          "$status"
          "[](fg:${colours.base0D})"
          "$line_break"
          "$character"
        ];

        username = {
          show_always = true;
          format = "[ $user ]($style)";
          style_user = "bg:${colours.base08} fg:${colours.base00}";
        };

        directory = {
          format = "[ $path ]($style)";
          style = "bg:${colours.base09} fg:${colours.base00}";
        };

        git_branch = {
          format = "[ $symbol$branch ]($style)";
          style = "bg:${colours.base0A} fg:${colours.base00}";
        };

        git_status = {
          format = "[($all_status$ahead_behind )]($style)";
          style = "bg:${colours.base0A} fg:${colours.base00}";
        };

        dotnet = {
          format = "[ $symbol($version ) ]($style)";
          style = "bg:${colours.base0B} fg:${colours.base00}";
        };

        golang = {
          format = "[ $symbol($version ) ]($style)";
          style = "bg:${colours.base0B} fg:${colours.base00}";
        };

        java = {
          format = "[ $symbol($version ) ]($style)";
          style = "bg:${colours.base0B} fg:${colours.base00}";
        };

        lua = {
          format = "[ $symbol($version ) ]($style)";
          style = "bg:${colours.base0B} fg:${colours.base00}";
        };

        rust = {
          format = "[ $symbol($version ) ]($style)";
          style = "bg:${colours.base0B} fg:${colours.base00}";
        };

        zig = {
          format = "[ $symbol($version ) ]($style)";
          style = "bg:${colours.base0B} fg:${colours.base00}";
        };

        cmd_duration = {
          format = "[ took $duration ]($style)";
          style = "bg:${colours.base0C} fg:${colours.base00}";
        };

        status = {
          format = "[ $status ($common_meaning$signal_name) ]($style)";
          style = "bg:${colours.base0D} fg:${colours.base00}";
          disabled = false;
        };

        character = {
          success_symbol = "[ >](bold green)";
          error_symbol = "[ >](bold red)";
        };
      };
    };
  };
}

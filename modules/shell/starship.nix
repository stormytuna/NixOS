# TODO: Want to restyle this, not happy with the colours, with lighter background colours the username and path is unreadable
{
  config,
  lib,
  ...
}: let
  colours = config.lib.stylix.colors.withHashtag;
in {
  imports = [<home-manager/nixos>];

  options = {
    modules.shell.starship.enable = lib.mkEnableOption "Enables starship and configuration";
  };

  config = lib.mkIf config.modules.shell.starship.enable {
    home-manager.users.stormytuna.programs.starship = {
      enable = true;
      enableZshIntegration = true;

      # TODO: Move some of these into another module
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
{
  config,
  lib,
  ...
}: let
  colours = config.lib.stylix.colors.withHashtag;
in {
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      /*
      left hand side:
      directory
      cmd duration
      status

      right hand side:
      git repo
      time
      */

      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_status"
        "$fill"
        "$cmd_duration"
        "$status"
        "$time"
        "$line_break"
        "$character"
      ];

      directory = {
        format = "[ $path ]($style)";
        style = "fg:${colours.base0D}";
      };

      git_branch = {
        format = "[ $symbol$branch ]($style)";
        style = "fg:${colours.base0B}";
      };

      git_status = {
        format = "[($all_status$ahead_behind )]($style)";
        style = "fg:${colours.base0B}";
      };

      cmd_duration = {
        format = "[ took $duration ]($style)";
        style = "fg:${colours.base09}";
      };

      status = {
        format = "[ $status ($common_meaning$signal_name) ]($style)";
        style = "fg:${colours.base08}";
        disabled = false; # FSR starship provides modules but defaults them to disabled?
      };

      time = {
        format = "[ $time ]($style)";
        style = "fg:${colours.base0F}";
        disabled = false; # See above
      };

      fill = {
        symbol = " ";
      };

      character = {
        success_symbol = "[ >](bold green)";
        error_symbol = "[ >](bold red)";
      };

      /*

      Unused for now!

      username = {
        show_always = true;
        format = "[ $user ]($style)";
        style_user = "bg:${colours.base08} fg:${colours.base00}";
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
      */
    };
  };
}

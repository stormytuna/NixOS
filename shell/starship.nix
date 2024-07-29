{ config, lib, ... }:

let
  colours = config.lib.stylix.colors.withHashtag;
in
{
  imports = [ <home-manager/nixos> ];

  home-manager.users.stormytuna.programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      format = lib.concatStrings [
        "[](${colours.base04})"
        "$username"
        "$directory"
        "[](fg:${colours.base04} bg:${colours.base03})"
        "$git_branch"
        "$git_status"
        "[](fg:${colours.base03} bg:${colours.base02})"
        "$dotnet"
        "$golang"
        "$java"
        "$lua"
        "$rust"
        "$zig"
        "[](fg:${colours.base02} bg:${colours.base01})"
        "$cmd_duration"
        "[](fg:${colours.base01})"
        "$line_break"
        "$character"
      ];

      username = {
        show_always = true;
        format = "[ $user ]($style)";
        style_user = "bg:${colours.base04} fg:${colours.base08}";
      };

      directory = {
        format = "[ $path ]($style)";
        style = "bg:${colours.base04} fg:${colours.base09}";
        substitutions = {
          Documents = "󰈙 ";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
        };
      };

      git_branch = {
        format = "[ $symbol$branch ]($style)";
        style = "bg:${colours.base03} fg:${colours.base0A}";
      };

      git_status = {
        format = "[($all_status$ahead_behind )]($style)";
        style = "bg:${colours.base03} fg:${colours.base0B}";
      };

      dotnet = {
        format = "[ $symbol($version ) ]($style)";
        style = "bg:${colours.base02} fg:${colours.base0C}";
      };

      golang = {
        format = "[ $symbol($version ) ]($style)";
        style = "bg:${colours.base02} fg:${colours.base0C}";
      };

      java = {
        format = "[ $symbol($version ) ]($style)";
        style = "bg:${colours.base02} fg:${colours.base0C}";
      };

      lua = {
        format = "[ $symbol($version ) ]($style)";
        style = "bg:${colours.base02} fg:${colours.base0C}";
      };

      rust = {
        format = "[ $symbol($version ) ]($style)";
        style = "bg:${colours.base02} fg:${colours.base0C}";
      };

     zig = {
        format = "[ $symbol($version ) ]($style)";
        style = "bg:${colours.base02} fg:${colours.base0C}";
     };

      cmd_duration = {
        format = "[ took $duration ]($style)";
        style = "bg:${colours.base01} fg:${colours.base0D}";
      };

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };
    };
  };
}

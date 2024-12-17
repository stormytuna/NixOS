{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.vencord;
in {
  options.modules.programs.vencord = {
    enable = lib.mkEnableOption "";
    horizontalServerList = lib.mkEnableOption "Use horizontal server width css";
  };

  config = lib.mkIf config.modules.programs.vencord.enable {
    home.packages = [(pkgs.discord.override {withVencord = true;})];

    home.file.".config/discord/settings/quickCss.css".text =
      ''
        @import url("https://minidiscordthemes.github.io/Snippets/ChannelListWidth/main.css");
        @import url("https://minidiscordthemes.github.io/Snippets/MinimalSearchbar/main.css");
        @import url("https://minidiscordthemes.github.io/Snippets/RoleTint/main.css");
        @import url("https://raw.githubusercontent.com/DiscordStyles/HorizontalServerList/deploy/HorizontalServerList.theme.css");

        :root {
          --channellist-width: 200px;
          --channellist-header-height: 48px;
        }

        /* Hide chatbox when no permissions to talk */
        [class*="channelTextAreaDisabled-"] > div {
          display: none;
        }

        /* Bottom HorizontalServerList. Simply remove the comments surrounding the @import to enable it. */
        /* @import url("https://discordstyles.github.io/HorizontalServerList/bottomhsl.css"); */
        :root {
          --HSL-server-icon-size: 40px; /* Size of the server icons | DEFAULT: 40px */
          --HSL-server-spacing: 10px; /* Spacing between each server icon | DEFAULT: 10px */
          --HSL-server-direction: column; /* Direction of the server list. | OPTIONS: column, column-reverse | DEFAULT: column */
          --HSL-server-alignment: flex-start; /* Alignment of the server list. | OPTIONS: flex-start, center, flex-end | DEFAULT: flex-start */
        }
      ''
      + lib.optionalString cfg.horizontalServerList ''
        /* Horizontal server list */
        @import url('https://discordstyles.github.io/HorizontalServerList/dist/HorizontalServerList.css');
      '';
  };
}

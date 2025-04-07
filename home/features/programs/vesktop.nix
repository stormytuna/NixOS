{pkgs, ...}: {
  home.packages = [pkgs.vesktop];

  home.file.".config/vesktop/settings/quickCss.css".text = ''
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

    /* Adds dropshadow outline to emotes */
    img.emoji {
      padding-top: 2px;
      padding-bottom: 2px;
      filter:
        drop-shadow(-1px -1px 0px black)
        drop-shadow(1px -1px 0px black)
        drop-shadow(-1px 1px 0px black)
        drop-shadow(1px 1px 0px black);
    }

    /* Horizontal server list */
    @import url('https://discordstyles.github.io/HorizontalServerList/dist/HorizontalServerList.css');
  '';
}

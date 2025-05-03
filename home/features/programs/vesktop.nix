{pkgs, ...}: {
  home.packages = [pkgs.stable.vesktop];

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
    /* @import url('https://discordstyles.github.io/HorizontalServerList/HorizontalServerList.css'); */
  '';
}

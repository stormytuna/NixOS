{config, ...}: {
  programs.obsidian = {
    enable = true;
  };

  home.file."ws/vaults/dnd/.obsidian/themes/Stylix/manifest.json".text = ''
    {
      "name": "Stylix",
      "version": "0.0.1",
      "minAppVersion": "0.16.0",
      "author": "stormytuna",
      "authorUrl": "https://github.com/stormytuna"
    }
  '';

  home.file."ws/vaults/dnd/.obsidian/themes/Stylix/theme.css".text = let
    colours = config.lib.stylix.colors.withHashtag;
  in ''
    :root {
      --base00: ${colours.base00};
    }
  '';
}

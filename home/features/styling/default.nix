{pkgs, ...}: {
  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus";
  };

  stylix = {
    enable = true;
    autoEnable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/da-one-ocean.yaml";

    image = ./wallpapers/orbit.jpg;

    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 32;
    };

    fonts = {
      # Font faces
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      monospace = {
        /*
        name = "Hasklug Nerd Font";
        package = pkgs.nerd-fonts.hasklug;
        */
        name = "Fira Code Nerd Font";
        package = pkgs.nerd-fonts.fira-code;
      };
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-color-emoji;
      };

      # Font sizes
      sizes = {
        applications = 14;
        desktop = 10;
        popups = 10;
        terminal = 16;
      };
    };

    opacity.terminal = 0.9;

    targets.mangohud.enable = false;
    targets.waybar.enable = false; # Stylix has awful waybar styles by default
  };
}

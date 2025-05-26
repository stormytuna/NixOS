{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./global

    ./features/shell
    ./features/styling

    #./features/desktops/hyprland.nix
    ./features/desktops/sway.nix

    ./features/development/csharp.nix

    ./features/programs/eww.nix
    ./features/programs/kitty.nix
    ./features/programs/mangohud.nix
    ./features/programs/neovim.nix
    ./features/programs/rider.nix
    ./features/programs/spotify.nix
    ./features/programs/vesktop.nix
    ./features/programs/vscode.nix
    #./features/programs/waybar.nix
    ./features/programs/wofi.nix
    ./features/programs/zen-browser.nix

    #./features/services/clear-downloads.nix
    ./features/services/dunst.nix
    #./features/services/flameshot.nix
    #./features/services/swaync.nix
    ./features/services/syncthing.nix
    ./features/services/wlsunset.nix
  ];

  home = {
    username = "stormytuna";
    homeDirectory = "/home/stormytuna";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    pictures = "media/images";
    videos = "media/videos";
    download = "downloads";
    documents = "docs";
    desktop = "desktop";

    extraConfig = {
      XDG_WORKSPACE_DIR = "${config.home.homeDirectory}/ws";
      XDG_CODE_DIR = "${config.home.homeDirectory}/ws/src";
      XDG_SEED_DIR = "${config.home.homeDirectory}/.seed";
    };

    templates = null;
    publicShare = null;
    music = null;
  };
  programs.bash.enable = true; # Required for xdg env vars to link properly

  home.file."games".source = config.lib.file.mkOutOfStoreSymlink "/mnt/Games";

  home.packages = with pkgs; [
    stable.lutris # Generic games library
    stable.prismlauncher # Minecraft launcher
    stable.r2modman # Thunderstore modloader
    sgdboop # Tool to apply assets automatically from SteamGridDB to games in steam library

    obsidian # Note taking software
    aseprite # Pixel art
    gimp3-with-plugins # Image editing
    audacity # Audio editing software
    davinci-resolve # Video editing software
    spotdl # Spotify audio downloader

    stable.pavucontrol # PulseAudio volume controller
    stable.qbittorrent # Torrenting software
    unityhub # Game engine
    stable.obs-studio # FOSS video recording and live streaming software
    # stable because chromium takes years to build and frequently blocks builds when not in cache
    stable.chromium # Web browser for when zen is playing up
    stable.premid # Discord RP for browser based videos, music, etc
    stable.calibre # e-book software
    stable.ryujinx # Switch emulator

    # PS4 emulator, overriding to use a modern version for FSR
    (shadps4.overrideAttrs (prev: {
      version = "git";
      src = fetchFromGitHub {
        owner = "shadps4-emu";
        repo = "shadPS4";
        rev = "aa8dab5371777105a3112498faa821d79aa3cab4";
        hash = "sha256-TfxHdBFeEdhXkkShAGcHObDP0bQzvitNjFs4JfX1yaI=";
        fetchSubmodules = true;
      };
    }))
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

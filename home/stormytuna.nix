{pkgs, ...}: {
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
    ./features/programs/spotify.nix
    ./features/programs/vesktop.nix
    ./features/programs/vscode.nix
    ./features/programs/waybar.nix
    ./features/programs/wofi.nix
    ./features/programs/zen-browser.nix

    ./features/services/clear-downloads.nix
    ./features/services/dunst.nix
    #./features/services/swaync.nix
    ./features/services/wlsunset.nix
  ];

  home = {
    username = "stormytuna";
    homeDirectory = "/home/stormytuna";
  };

  home.packages = with pkgs; [
    stable.lutris # Generic games library
    stable.prismlauncher # Minecraft launcher
    stable.r2modman # Thunderstore modeloader
    sgdboop # Tool to apply assets automatically from SteamGridDB to games in steam library

    #jetbrains-toolbox # Was having issues with installing rider so installed it via the toolbox
    jetbrains.rider

    aseprite # Pixel art
    gimp3-with-plugins # Image editing

    stable.bitwarden # Passwords and secrets manager
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

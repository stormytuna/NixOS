{pkgs, pkgs-unstable, pkgs-master, ...}: {
  imports = [
    ./hardware-configuration.nix

    ../../users/stormytuna.nix

    ../../features/desktops/sway.nix
    #../../features/desktops/hyprland.nix
    #../../features/desktops/cosmic.nix

    ../../features/hardware/amd-graphics.nix
    ../../features/hardware/audio.nix
    ../../features/hardware/bluetooth.nix
    ../../features/hardware/swap.nix
    # https://github.com/NixOS/nixpkgs/issues/575192
    #../../features/hardware/xone.nix
    ../../features/hardware/xpadneo.nix

    ../../features/programs/gamemode.nix
    ../../features/programs/gamescope.nix
    ../../features/programs/git.nix
    ../../features/programs/nh.nix
    ../../features/programs/nix.nix
    ../../features/programs/obs-studio.nix
    ../../features/programs/spotify.nix
    ../../features/programs/starship.nix
    ../../features/programs/steam.nix
    ../../features/programs/thunar.nix

    ../../features/services/flatpak.nix
    ../../features/services/foundry-vtt.nix
    ../../features/services/gnome-keyring.nix
    ../../features/services/sddm.nix
  ];

  nixpkgs = {
    config = {
     allowUnfree = true;
     permittedInsecurePackages = [
       "pnpm-10.29.2"
       "electron-40.10.5"
     ];
    };
  };

  # allow running unpatched dynamic libraries
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      alsa-lib
      at-spi2-atk
      atk
      cairo
      cups
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3
      libdrm
      libgbm
      libx11
      libxcb
      libxcomposite
      libxcursor
      libxdamage
      libxext
      libxfixes
      libxi
      libxkbcommon
      libxrandr
      libxrender
      libxshmfence
      mesa
      nspr
      nss
      pango
      stdenv.cc.cc.lib
    ];
  };

  environment.systemPackages = (with pkgs; [
    # info: stable packages
    # add anything that doesn't *need* to be up-to-date for daily usage

    # programs
    aseprite
    audacity
    chromium
    davinci-resolve
    (discord.override {withVencord = true;})
    gimp3-with-plugins
    lmms
    lutris
    mangohud
    pavucontrol
    qbittorrent
    qutebrowser
    r2modman
    slack
    smplayer

    # other stuff
    # warn: updating these is not enough to apply the change
    # they are set in the desktop environment's config
    adw-gtk3
    papirus-icon-theme
  ]) ++ (with pkgs-unstable; [
    # info: unstable packages
    # add anything that should be latest "stable" version
    #   stable is very loose here, packages may need to be moved to the above array instead

    # programs
    neovim
    nushell
    obsidian

    # shell utils
    bat
    btop
    carapace
    chezmoi
    comma
    delta
    fd
    ffmpeg
    ffmpeg-normalize
    flavours
    fzf
    gcc
    gh
    glib
    imagemagick
    jq
    lazygit
    libnotify
    mpv
    nix-output-monitor
    pnpm
    qmk
    ripgrep
    sgdboop
    spotdl
    starship
    systemctl-tui
    tldr
    (unp.override {extraBackends = [unrar p7zip];})
    vulkan-tools
    wineWow64Packages.waylandFull
    winetricks
    yt-dlp
    yq-go
    zoxide

    # go service deps
    go-swag
    golangci-lint

    # development
    dotnet-sdk_10
    gcc
    glib
    gnumake
    go
    jdk8_headless
    maven
    netcoredbg
    nodejs

    # lsps
    angular-language-server
    csharp-ls
    gopls
    jdt-language-server
    lua-language-server
    nil
    omnisharp-roslyn
    typescript-language-server
    vscode-langservers-extracted
    zls
  ]) ++ (with pkgs-master; [
    # info: packages directly served from the master branch
    # anything here should only be here temporarily
    # this is a stop-gap solution for if a package really needs to be up-to-date and
    #   i can't wait for it to enter unstable

    go-mockery
  ]);

  environment.variables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
    DOTNET_ROOT_X64 = "${pkgs.dotnet-sdk_10}/share/dotnet";
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "eva-unit-01";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # 25565 - Minecraft servers
      # 30000/31000 - Foundry VTT server
      allowedTCPPorts = [25565 30000 31000];
      allowedUDPPorts = [25565];
    };
  };

  fonts.packages = [
    pkgs.nerd-fonts.noto
    pkgs.nerd-fonts.fira-code
    pkgs.noto-fonts-color-emoji
    pkgs.font-awesome
  ];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # despite all my rage i am still just a (british) rat in a cage
  console.keyMap = "us";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

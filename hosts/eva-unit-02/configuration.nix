{pkgs, pkgs-unstable, pkgs-master, ...}: {
  # TODO: Imports and organise that stuff and port all home manager stuff
  imports = [
    ./hardware-configuration.nix

    # Users
    ../../users/stormytuna.nix

    # Features
    ../../features/desktops/sway.nix

    ../../features/hardware/bluetooth.nix
    ../../features/hardware/swap.nix

    ../../features/programs/git.nix
    ../../features/programs/nh.nix
    ../../features/programs/nix.nix
    ../../features/programs/starship.nix
    ../../features/programs/steam.nix
    ../../features/programs/thunar.nix

    ../../features/services/flatpak.nix
    ../../features/services/gnome-keyring.nix
    ../../features/services/sddm.nix
  ];

  # TODO: Is there a better way to apply overlays?
  nixpkgs = {
    overlays = [
      #outputs.overlays.additions
      #outputs.overlays.modifications
      #outputs.overlays.scripts
      #outputs.overlays.unstable-packages
    ];
    config = {
     allowUnfree = true;
     permittedInsecurePackages = [
       "electron-40.10.5"
       "pnpm-10.29.2"
     ];
    };
  };

  # Allow running unpatched dynamic libraries
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
    chromium
    (discord.override {withVencord = true;})
    nushell
    obsidian
    pavucontrol
    slack
    smplayer

    # shell utils
    azure-cli
    claude-code # i promise i'm not a meat proxy

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

    # shell utils
    bat
    btop
    carapace
    carbon-now-cli
    chezmoi
    comma
    delta
    fd
    flavours
    fzf
    gh
    gnumake
    jq
    jx
    kanshi
    kubectl
    kubelogin
    lazygit
    lens
    libnotify
    mpv
    nix-output-monitor
    pnpm
    podman
    python3
    qmk
    ripgrep
    starship
    systemctl-tui
    tlrc
    (unp.override {extraBackends = [unrar p7zip];})
    uv
    vi-mongo
    yq-go
    zoxide

    # go service deps
    go-swag
    golangci-lint

    # development
    dotnet-sdk_10
    gcc
    glib
    go
    netcoredbg
    nodejs

    # lsps
    omnisharp-roslyn
    csharp-ls
    lua-language-server
    typescript-language-server
    nil
    angular-language-server
    gopls
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
    hostName = "eva-unit-02";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };

  fonts.packages = [
    pkgs.nerd-fonts.noto
    pkgs.nerd-fonts.fira-code
    pkgs.noto-fonts-color-emoji
    pkgs.noto-fonts-cjk-sans
    pkgs.font-awesome
  ];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Despite all my rage I am still just a (british) rat in a cage
  console.keyMap = "us";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

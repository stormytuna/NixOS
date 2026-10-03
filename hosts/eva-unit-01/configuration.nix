{pkgs, pkgs-stable, ...}: {
  # TODO: Imports and organise that stuff and port all home manager stuff
  imports = [
    ./hardware-configuration.nix

    # Users
    ../../users/stormytuna.nix

    # Features
    ../../features/desktops/sway.nix

    ../../features/hardware/amd-graphics.nix
    ../../features/hardware/audio.nix
    ../../features/hardware/bluetooth.nix
    ../../features/hardware/swap.nix
    ../../features/hardware/xone.nix
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
       "xpdf-4.06"
       "pnpm-10.29.2"
       "electron-40.10.5"
     ];
    };
  };

  # Allow running unpatched dynamic libraries
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    # Programs
    pkgs-stable.aseprite
    audacity
    chromium
    pkgs-stable.davinci-resolve
    (discord.override {withVencord = true;})
    gimp3-with-plugins
    keepass
    lmms
    lutris
    mangohud
    neovim
    nushell
    obsidian
    pavucontrol
    #pcsx2
    pkgs-stable.qbittorrent
    pkgs-stable.r2modman
    retroarch-full
    pkgs-stable.smplayer
    unityhub
    vscode.fhs
    xpdf
    zed-editor

    # Shell utils
    android-tools
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
    glib
    imagemagick
    jq
    lazygit
    libnotify
    linuxKernel.packages.linux_6_6.cpupower
    mpv
    nix-output-monitor
    pnpm
    ripgrep
    sgdboop
    spotdl
    starship
    tldr
    (unp.override {extraBackends = [unrar p7zip];})
    vulkan-tools
    wineWow64Packages.waylandFull
    winetricks
    zoxide

    # Development, LSPs, etc 
    # TODO: Cleanup
    (dotnetCorePackages.combinePackages [
      dotnetCorePackages.sdk_8_0
      dotnetCorePackages.sdk_9_0 # Required for roslyn LSP
      dotnetCorePackages.sdk_10_0-bin # Required for csharp-ls
    ])
    netcoredbg # C# debugger
    raylib
    libx11 # Xlib, required for running raylib projects
    nodejs
    roslyn-ls
    omnisharp-roslyn
    csharp-ls
    lua-language-server
    typescript-language-server
    nil
    godot_4
    jdk8_headless
    maven
    jdt-language-server
    vscode-langservers-extracted
    zls

    # FNA development stuff
    fna3d
    sdl3
    faudio
     
    # Other stuff
    adw-gtk3
    papirus-icon-theme
  ];

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

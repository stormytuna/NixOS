{pkgs, pkgs-stable, ...}: {
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
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    # Programs
    chromium
    (discord.override {withVencord = true;})
    neovim
    nushell
    obsidian
    pavucontrol
    slack
    pkgs-stable.smplayer

    # Shell utils
    bat
    btop
    carapace
    chezmoi
    comma
    delta
    fd
    flavours
    fzf
    gcc
    glib
    gh
    jq
    lazygit
    libnotify
    nix-output-monitor
    pnpm
    ripgrep
    starship
    tlrc
    (unp.override {extraBackends = [unrar p7zip];})
    zoxide

    # Development, LSPs, etc 
    # TODO: Cleanup
    (dotnetCorePackages.combinePackages [
      dotnetCorePackages.sdk_8_0
    ])
    netcoredbg # C# debugger
    nodejs
    omnisharp-roslyn
    lua-language-server
    typescript-language-server
    nil
    #jdk8_headless
    #maven
    #jdt-language-server
     
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

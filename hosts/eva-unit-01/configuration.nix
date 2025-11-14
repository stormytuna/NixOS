{pkgs, ...}: {
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
    ../../features/services/syncthing.nix
  ];

  # TODO: Is there a better way to apply overlays?
  nixpkgs = {
    overlays = [
      #outputs.overlays.additions
      #outputs.overlays.modifications
      #outputs.overlays.scripts
      #outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    #sgdboop
    aseprite
    audacity
    comma
    davinci-resolve
    flavours
    gimp3-with-plugins
    jetbrains.rider
    libnotify
    lutris
    mangohud
    neovim
    nushell
    obsidian
    obsidian
    pavucontrol
    qbittorrent
    r2modman
    spotdl
    vesktop
    zoxide

    # ShadPS4 branch with patches necessary for bloodborne
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
      # 30000 - Foundry VTT server
      allowedTCPPorts = [25565 30000];
      allowedUDPPorts = [25565];
    };
  };

  fonts.packages = [
    pkgs.nerd-fonts.noto
    pkgs.nerd-fonts.fira-code
    pkgs.noto-fonts-color-emoji
  ];

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Despite all my rage I am still just a (british) rat in a cage
  console.keyMap = "us";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

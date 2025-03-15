{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager
  ];

  # Custom modules
  modules = {
    desktops = {
      #cosmic.enable = true;
      #gnome.enable = true;
      #hyprland.enable = true;
      #plasma.enable = true; # TODO: configure plasma with plasma-manager
      sway.enable = true;
    };
    development = {
      csharp.enable = true;
      java.enable = true;
    };
    programs = {
      #alacritty.enable = true;
      #bitwarden.enable = true;
      #heroic.enable = true;
      #prismlauncher.enable = true;
      #r2modman.enable = true;
      aseprite.enable = true;
      bat.enable = true;
      boilr.enable = true;
      btop.enable = true;
      carapace.enable = true;
      chromium.enable = true;
      comma.enable = true;
      fd.enable = true;
      ffmpeg.enable = true;
      #firefox.enable = true;
      fzf.enable = true;
      gamemode.enable = true;
      gamescope-cleanup.enable = true;
      git.enable = true;
      gimp.enable = true;
      #inkscape.enable = true;
      #librewolf.enable = true;
      lutris.enable = true;
      mangohud.enable = true;
      neovim.enable = true;
      nix-output-monitor.enable = true;
      nushell.enable = true;
      pavucontrol.enable = true;
      qbittorrent.enable = true;
      rider.enable = true;
      ripgrep.enable = true;
      #sidequest.enable = true;
      sgdboop.enable = true;
      spotify.enable = true;
      spotify.enableAdblock = true;
      starship.enable = true;
      thefuck.enable = true;
      unp.enable = true;
      tldr.enable = true;
      unityhub.enable = true;
      #vencord.enable = true;
      vesktop.enable = true;
      vscode.enable = true;
      vulkan-tools.enable = true;
      waybar.enable = true;
      wine.enable = true;
      wofi.enable = true;
      #zen-browser.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
    services = {
      swaync.enable = true;
    };
    styling = {
      stylix = {
        enable = true;
        wallpaperName = "space-blue.png";
        base16Scheme = "ocean";
        polarity = "dark";
        cursor = {
          package = pkgs.quintom-cursor-theme;
          name = "Quintom_Ink";
          size = 24;
        };
        icons = {
          package = pkgs.qogir-icon-theme;
          name = "Qogir";
        };
      };
    };
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.scripts
      outputs.overlays.stable-packages
      outputs.overlays.nur
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-core-combined"
        "dotnet-sdk-6.0.428"
        "dotnet-sdk-wrapped-6.0.428"
        "dotnet-runtime-6.0.36"
        "dotnet-runtime-wrapped-6.0.36"
        "dotnet-sdk-7.0.410"
      ];
    };
  };

  home = {
    username = "stormytuna";
    homeDirectory = "/home/stormytuna";
  };

  # Disable the silly news notifications
  news.display = "silent";

  programs.home-manager.enable = true;

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

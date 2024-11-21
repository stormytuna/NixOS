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
      hyprland.enable = true;
      #plasma.enable = true; # TODO: configure plasma with plasma-manager
      #sway.enable = true;
    };
    development = {
      csharp.enable = true;
    };
    programs = {
      #aseprite.enable = true;
      #bitwarden.enable = true;
      #heroic.enable = true;
      #lutris.enable = true;
      #prismlauncher.enable = true;
      #qbittorrent.enable = true;
      #r2modman.enable = true;
      #sidequest.enable = true;
      #vulkan-tools.enable = true;
      #wine.enable = true;
      alacritty.enable = true;
      bat.enable = true;
      btop.enable = true;
      comma.enable = true;
      fd.enable = true;
      ffmpeg.enable = true;
      fzf.enable = true;
      gamemode.enable = true;
      gamescope-cleanup.enable = true;
      git.enable = true;
      mangohud.enable = true;
      neovim.enable = true;
      nix-output-monitor.enable = true;
      nushell.enable = true;
      pavucontrol.enable = true;
      ripgrep.enable = true;
      spotify.enable = true;
      starship.enable = true;
      thefuck.enable = true;
      tldr.enable = true;
      vesktop.enable = true;
      waybar.enable = true;
      wofi.enable = true;
      zen-browser.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
    services = {
      swaync.enable = true;
    };
    styling = {
      stylix = {
        enable = true;
        wallpaperName = "frieren-tree.png";
        base16Scheme = "catppuccin-mocha";
        polarity = "dark";
        icons = {
          package = pkgs.kora-icon-theme;
          name = "kora";
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
    ];
    config = {
      allowUnfree = true;
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

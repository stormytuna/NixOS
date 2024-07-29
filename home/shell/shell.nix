{ pkgs, pkgs-stable, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    history.path = "$HOME/.config/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "command-not-found"
        "fancy-ctrl-z"
      ];
    };

    shellAliases = {
      # nixos
      update-system = "sudo nixos-rebuild switch --flake '/home/stormytuna/.nixos/' --impure";
      update-home = "home-manager switch --flake '/home/stormytuna/.nixos/' --impure";
      update-flake = "sudo nix flake update /home/stormytuna/.nixos/";
      update-all = "update-flake && update-system && update-home";
      update = "update-system && update-home";

      # exa
      ls = "eza";
      ll = "eza --long --icons --colour always --group-directories-first";
      la = "ll --all";
      lt = "ll --all --tree";

      # nvim
      v = "nvim";
      qvf = "nvim ~/.nixos/flake.nix";

      # git
      ga = "git add *";
      gs = "git status";
      gc = "git commit -m";
      gpush = "git push origin";
      gpull = "git pull origin";

      # misc
      cat = "bat";
      cl = "clear; fastfetch";
      neofetch = "fastfetch";
    };

    initExtra = ''
      # Capitalisation agnostic tab matching
      zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # TODO: See what packages here can be moved out and configured
  home.packages = with pkgs; [
    tldr
    pkgs-stable.thefuck # Broken on unstable currently
    fastfetch
    ripgrep
    imagemagick
    git
    fzf
    fd
    eza
    btop
    bat
    killall
    gettext # Utility for printing terminal colours
  ];

  # Configs
  home.file.".config/fastfetch/config.jsonc".source = ../config/fastfetch/fastfetch.jsonc;
}

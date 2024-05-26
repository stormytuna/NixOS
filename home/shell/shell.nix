{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh"; # already relative to home dir
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
      update-system = "sudo nixos-rebuild switch --flake '/home/stormytuna/.nixos/'";
      update-home = "home-manager switch --flake '/home/stormytuna/.nixos/'";
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

      # git
      ga = "git add *";
      gs = "git status";
      gc = "git commit -m";
      gpush = "git push origin";
      gpull = "git pull origin";

      # misc
      cat = "bat";
      cl = "clear";
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

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;

      format = lib.concatStrings [
        "$username $directory"
        "$git_branch"
        "$git_status"
        "$cmd_duration $time"
        "$line_break"
        "$character"
        "$nix_shell"
      ];

      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "blue";
        style_root = "yellow";
      };

      git_branch.format = "[$symbol$branch(:$remote_branch)]($style)";
      git_status = {
        format = "\\[$ahead_behind$modified$untracked$deleted$stashed$staged$renamed\\]";
        ahead = "[($count)](green)";
        behind = "[($count)](red)";
        deleted = "[✘($count)](red)";
        diverged = "[($ahead_count)($beind_count)](yellow)";
        modified = "[⌁($count)](yellow)";
        renamed = "[($count)](yellow)";
        stashed = "[⚑($count)](blue)";
        untracked = "?($count)";
        up_to_date = "[](green)";
        staged = "[+($count)](green)";
      };

      time = {
        disabled = false;
        format = "$time";
      };

      cmd_duration.format = "[$duration]($style) |";

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };
    };
  };

  # TODO: See what packages here can be moved out and configured
  home.packages = with pkgs; [
    tldr
    thefuck
    neofetch # TODO: Find a cooler alternative!
    ripgrep
    imagemagick
    git
    fzf
    fd
    eza
    btop
    bat
    killall
  ];
}

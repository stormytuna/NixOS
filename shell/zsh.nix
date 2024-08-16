{pkgs, ...}: {
  imports = [<home-manager/nixos>];

  # We love being POSIX compliant
  environment.shells = with pkgs; [zsh];
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = ["/share/zsh"]; # Required for zsh completions for system packages

  # TODO: Finish this!
  home-manager.users.stormytuna.programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    history.path = "$HOME/.config/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "alias-finder"
        "colored-man-pages"
        "command-not-found"
        "fancy-ctrl-z"
      ];
      extraConfig = ''
        zstyle ':omz:plugins:alias-finder' autoload yes
        zstyle ':omz:plugins:alias-finder' longer yes
        zstyle ':omz:plugins:alias-finder' exact yes
        zstyle ':omz:plugins:alias-finder' cheaper yes
      '';
    };

    shellAliases = {
      # nixos
      update-flake = "sudo nix flake update /home/stormytuna/.nixos/ && update";
      update = "sudo nixos-rebuild switch --flake '/home/stormytuna/.nixos/' --impure --log-format internal-json -v |& nom --json; notify-send 'System update complete!'";

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
      cl = "clear";
      neofetch = "fastfetch";
    };

    initExtra = ''
      # Capitalisation agnostic tab matching
      zstyle ":completion:*" matcher-list "m:{a-z}={A-Za-z}"
    '';
  };
}

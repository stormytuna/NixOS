{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.programs.nushell;
  nomRedirect = "out+err>| ${pkgs.nix-output-monitor}/bin/nom";
in {
  options.modules.programs.nushell = {
    enable = lib.mkEnableOption "Data-based shell with modern design principles";
    makeDefault = lib.mkEnableOption "Make Nushell the user's default shell";
  };

  config = lib.mkIf cfg.enable {
    programs.nushell = {
      enable = true;

      configFile.text = ''
          $env.config = {
            show_banner: false
          keybindings: [
            {
              name: fuzzy_history
              modifier: control
              keycode: char_r
              mode: [emacs, vi_normal, vi_insert]
              event: [
                {
                  send: ExecuteHostCommand
                  cmd: "commandline edit --insert (
                    history
                      | get command
                      | reverse
                      | uniq
                      | str join (char -i 0)
                      | fzf
                        --preview '{}'
                        --preview-window 'right:30%'
                        --scheme history
                        --read0
                        --layout reverse
                        --height 40%
                        --query (commandline)
                      | decode utf-8
                      | str trim
                  )"
                }
              ]
            }
          ]
        }
      '';

      # Using extraConfig to insert aliases at end of config
      # shellAliases option was reordering aliases
      extraConfig = ''
        # NixOS update stuff
        def update-system [] { sudo nixos-rebuild switch --flake ~/.nixos ${nomRedirect} }
        def update-home [] { home-manager switch --flake ~/.nixos ${nomRedirect} }
        def update-flake [] { sudo nix flake update --flake ~/.nixos }
        def update-all [] { update-flake; update-system; update-home }

        # git
        alias gs = git status
        alias gc = git commit --message
        alias ga = git add --all
        alias gp = git push
        alias gpl = git pull
        alias gb = git branch

        # misc stuff
        def lg [path = "."] { ls $path | sort-by type name --ignore-case | grid --icons --color } # Quick filename view of directory
        def ll [path = "."] { ls --long $path | sort-by type name --ignore-case | select mode user group type name size created accessed modified }
        alias qvf = nvim ~/.nixos
        alias cl = clear

        # remove latest things from history file
        def forget [count = 1] {
          # double reverse as we want the duplicate entries to appear lower at the list
          history | get command | reverse | uniq | reverse | drop $count | save ~/.config/nushell/history.txt --force
        }
      '';
    };
  };
}

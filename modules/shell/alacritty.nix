{
  config,
  lib,
  ...
}: {
  imports = [<home-manager/nixos>];

  options = {
    modules.shell.alacritty.enable = lib.mkEnableOption "Enables alacritty and configuration";
  };

  config = lib.mkIf config.modules.shell.alacritty.enable {
    home-manager.users.stormytuna.programs.alacritty = {
      enable = true;
      settings = {
        window = {
          decorations = "None";
        };
      };
    };
  };
}

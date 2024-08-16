{...}: {
  imports = [<home-manager/nixos>];

  home-manager.users.stormytuna.programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
      };
    };
  };
}

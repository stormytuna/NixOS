{ lib, userSettings, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.stormytuna.programs.wofi = { 
    enable = true;

    settings = {
      show = "drun";
      allow_images = true;
      insensitive = true;
      key_forward = "Ctrl-n";
      key_backward = "Ctrl-p";
      key_submit = "Ctrl-y";
    };

    style = lib.mkForce ''
      * { 
        font-family: "${userSettings.fonts.monospace.name}";
      }
    '';
  };
}

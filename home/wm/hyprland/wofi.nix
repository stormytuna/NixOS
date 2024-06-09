{ userSettings, ... }:

{
  programs.wofi = { 
    enable = true;

    settings = {
      show = "drun";
      allow_images = true;
      insensitive = true;
      key_forward = "Ctrl-n";
      key_backward = "Ctrl-p";
      key_submit = "Ctrl-y";
    };

    style = ''
      * { 
        font-family: "${userSettings.fonts.monospace.name}";
      }
    '';
  };
}

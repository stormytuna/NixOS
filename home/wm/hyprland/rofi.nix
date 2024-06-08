{ ... }:

{
  programs.rofi = {
    enable = true;
    extraConfig = {
      modi = "drun,run,filebrowser,ssh,window"; # No whitespace because rofi doesn't filter it out for us
      show-icons = true;
      display-drun = "Apps";
      display-run = "Run";
      display-filebrowser = "Files";
      display-window = "Windows";
      display-ssh = "SSH";
      drun-display-format = "{name}";
      window-format = "{w} - {c} - {t}";
    };
  };
}

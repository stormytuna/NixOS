{pkgs, ...}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
  };

  programs.file-roller.enable = true; # Allows unpacking archives
  programs.xfconf.enable = true; # Allows saving preferences

  services = {
    gvfs.enable = true; # Mount and trash functionality
    tumbler.enable = true; # Show thumbnails for images
  };
}

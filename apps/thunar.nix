{pkgs, ...}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
  };

  environment.systemPackages = [pkgs.gvfs];

  programs.xfconf.enable = true; # Required for configs to be saved

  services.gvfs.enable = true; # Mount and trash functionality
  services.tumbler.enable = true; # Thumbnail support for images
}

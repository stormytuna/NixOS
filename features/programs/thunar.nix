{pkgs, ...}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-volman
      thunar-archive-plugin
    ];
  };

  environment.systemPackages = with pkgs; [
	file-roller # Allows unpacking archives
  ];

  programs.xfconf.enable = true; # Allows saving preferences

  services = {
    gvfs.enable = true; # Mount and trash functionality
    tumbler.enable = true; # Show thumbnails for images
  };
}

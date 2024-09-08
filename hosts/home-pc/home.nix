{...}: {
  imports = [
    <home-manager/nixos>
  ];

  home-manager.backupFileExtension = "backup";

  home-manager.users.stormytuna = {pkgs, ...}: {
    # Username and home directory
    home.username = "stormytuna";
    home.homeDirectory = "/home/stormytuna";

    # Extra desktop files
    xdg.desktopEntries.yomihustle = {
      exec = ''
        sh -c "wine ~/Code/YOMIHustle/windows-351-editor-64bit.exe"
      '';
      name = "YOMIHustle Project";
      genericName = "YOMIHustle Project";
      icon = "godot";
      type = "Application";
    };

    # Allow unfree packages
    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    # let home manager install and manage itself
    programs.home-manager.enable = true;

    # Keep this for compatibility
    home.stateVersion = "23.11";
  };
}

{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];

  options = {
    modules.dev.git.enable = lib.mkEnableOption "Enables git and configuration";
  };

  config = lib.mkIf config.modules.dev.git.enable {
    home-manager.users.stormytuna.programs.git = {
      enable = true;
      userName = "stormytuna";
      userEmail = "stormytuna@outlook.com";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
        http.postBuffer = 157286400; # Fixes timeouts for git pushing large files
      };
    };
  };
}

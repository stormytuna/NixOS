{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.git = {
    enable = lib.mkEnableOption "Version control system";
  };

  config = lib.mkIf config.modules.programs.git.enable {
    programs.git = {
      enable = true;
      userName = "stormytuna";
      userEmail = "stormytuna@outlook.com";
      extraConfig = {
        init.defaultBranch = "main";
        credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
        http.postBuffer = 157286400; # Fixes timeouts when pushing larger files
      };
    };
  };
}

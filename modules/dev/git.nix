{
  pkgs,
  userSettings,
  ...
}: {
  imports = [<home-manager/nixos>];

  home-manager.users.stormytuna.programs.git = {
    enable = true;
    userName = userSettings.username;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
      http.postBuffer = 157286400; # Fixes timeouts for git pushing large files
    };
  };
}

{pkgs, ...}: {
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
      http.postBuffer = 157286400; # Fixes timeouts from pushing larger commits
    };
  };
}

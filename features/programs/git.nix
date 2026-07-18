{pkgs, ...}: {
  programs.git = {
    enable = true;
    # TODO: Finish
    config = {
      credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
      remote.origin.fetch = "+refs/pull/*/head:refs/remotes/origin/pr/*";
    };
  };
}

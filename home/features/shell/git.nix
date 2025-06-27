{pkgs, ...}: {
  programs.git = {
    enable = true;

    userName = "stormytuna";
    userEmail = "stormytuna@outlook.com";

    extraConfig = {
      init.defaultBranch = "main";

      core.pager = "delta"; # Nicer diff view than default
      diff.algorithm = "histogram"; # Better diff handling for code files

      rebase.autostash = true; # Stash before a `git pull`, then pop afterwards
      push.autoSetupRemote = true; # Create a remote branch if one doesn't already exist when pushing
      pull.rebase = true; # Default to `git pull --rebase`
      rerere.enabled = true; # Reuse Recovered Resolution, prevents having to resolve the same conflict multiple times with rebase
      fetch.prune = true; # Delete tracked remotes that have been deleted

      status.submoduleSummary = true; # Make `git status` more useful in repos with submodules
      diff.submodule = "log"; # Make `git diff` more useful in repos with submodules
      submodule.recurse = true; # Makes common git operations run in submodules too

      credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
      http.postBuffer = 157286400; # Fixes timeouts from pushing larger commits
    };
  };
}

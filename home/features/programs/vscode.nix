{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs; # VSC config is mostly declarative, maybe I'll change this later
  };
}

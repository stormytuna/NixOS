{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.vscode = {
    enable = lib.mkEnableOption "Extensible text editor";
  };

  config = lib.mkIf config.modules.programs.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs; # VSC config is mostly declarative, maybe I'll change this later
    };
  };
}

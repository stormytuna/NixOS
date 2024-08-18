{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];

  options = {
    modules.dev.vscode.enable = lib.mkEnableOption "Enables visual studio code and configs";
  };

  config = lib.mkIf config.modules.dev.vscode.enable {
    home-manager.users.stormytuna.programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        ms-dotnettools.csharp
        ms-dotnettools.csdevkit
        ms-dotnettools.vscode-dotnet-runtime
      ];
    };
  };
}

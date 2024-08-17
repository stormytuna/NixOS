{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    <home-manager/nixos>
    ./git.nix
    ./java.nix
    ./csharp.nix
  ];

  environment.systemPackages = with pkgs; [
    neovim
    github-desktop
    jetbrains.rider
    avalonia-ilspy
  ];

  programs.adb.enable = true;

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
}

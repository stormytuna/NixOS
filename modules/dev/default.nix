{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    <home-manager/nixos>
    ./csharp.nix
    ./git.nix
    ./java.nix
    ./neovim.nix
    ./vscode.nix
  ];

  options = {
    modules.dev.enable = lib.mkEnableOption "Enables various development options that don't have their own modules";
  };

  config = lib.mkIf config.modules.dev.enable {
    environment.systemPackages = with pkgs; [
      github-desktop
    ];

    programs.adb.enable = true;
  };
}

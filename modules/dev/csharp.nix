{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.dev.csharp.enable = lib.mkEnableOption "Enables necessary packages for csharp development";
  };

  config = lib.mkIf config.modules.dev.csharp.enable {
    environment.systemPackages = with pkgs; [
      dotnet-sdk_8
      omnisharp-roslyn
      mono
      msbuild
      avalonia-ilspy
    ];
  };
}

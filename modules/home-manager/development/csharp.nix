{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.development.csharp = {
    enable = lib.mkEnableOption "Various tools for C# and dotnet development";
  };

  config = lib.mkIf config.modules.development.csharp.enable {
    home.packages = with pkgs; [
      dotnet-sdk_8 # Latest LTS dotnet sdk
      omnisharp-roslyn # dotnet development platform based on Roslyn
      msbuild # Build platform for dotnet
      avalonia-ilspy # dotnet decompiler
    ];
  };
}

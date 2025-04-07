{pkgs, ...}: {
  home.packages = with pkgs; [
    dotnet-sdk_8 # Latest LTS dotnet sdk
    omnisharp-roslyn # dotnet development platform based on Roslyn
    msbuild # Build platform for dotnet
    avalonia-ilspy # dotnet decompiler
  ];
}

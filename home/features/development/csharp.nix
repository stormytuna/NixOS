{pkgs, ...}: {
  home.packages = with pkgs; [
    dotnet-sdk_8 # Required for tModLoader
    dotnet-sdk
    msbuild # Build platform for dotnet
    avalonia-ilspy # dotnet decompiler
  ];
}

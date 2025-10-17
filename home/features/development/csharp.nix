{pkgs, ...}: {
  home.packages = with pkgs; [
    dotnet-sdk_8 # Required for tModLoader
    msbuild # Build platform for dotnet
    avalonia-ilspy # dotnet decompiler

    raylib # Minimal game engine thingy
  ];
}

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dotnet-sdk_8 # TODO: Need multiple SDKs
    omnisharp-roslyn
    mono
    msbuild
  ];
}

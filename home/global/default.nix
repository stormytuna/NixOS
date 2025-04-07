{outputs, ...}: {
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.scripts
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-core-combined"
        "dotnet-sdk-6.0.428"
        "dotnet-sdk-wrapped-6.0.428"
        "dotnet-runtime-6.0.36"
        "dotnet-runtime-wrapped-6.0.36"
        "dotnet-sdk-7.0.410"
      ];
    };
  };

  # Disable the silly news notifications
  news.display = "silent";
  programs.home-manager.enable = true;

  # Reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}

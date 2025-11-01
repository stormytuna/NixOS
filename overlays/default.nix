{inputs, ...}: {
  # Import added packages our custom packages
  additions = final: prev: import ../pkgs final.pkgs;

  # Apply overrides and modifications to any packages
  modifications = final: prev: {
    # Import developer hyrland packages
    #hyprland = inputs.hyprland.packages.${prev.stdenv.hostPlatform.system}.hyprland;
    #xdg-desktop-portal-hyprland = inputs.hyprland.packages.${prev.stdenv.hostPlatform.system}.hyprland;

    # Make rider work with unity
    rider = prev.jetbrains.rider.overrideAttrs (attrs: {
      postInstall =
        ''
          # Making Unity Rider plugin work!
          # The plugin expects the binary to be at /rider/bin/rider, with bundled files at /rider/
          # It does this by going up two directories from the binary path
          # Our rider binary is at $out/bin/rider, so we need to link $out/rider/ to $out/
          shopt -s extglob
          ln -s $out/rider/!(bin) $out/
          shopt -u extglob
        ''
        + attrs.postInstall or "";
    });

    # Add other vscode extensions
    vscode-extensions = prev.vscode-extensions // inputs.vscode-marketplace;

    # Apply patches
    #nix-output-monitor = prev.nix-output-monitor.overrideAttrs {
    #  patches = [../patches/nix-output-monitor-icons.patch];
    #};
  };

  scripts = final: prev: {
    scripts = import ../scripts final.pkgs;
  };

  # Allow access to stable packages
  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config = final.config;
    };
  };
}

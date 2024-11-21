{inputs, ...}: {
  # Import added packages our custom packages
  additions = final: _prev: import ../pkgs final.pkgs;

  # Apply overrides and modifications to any packages
  modifications = final: prev: {
    # Import developer hyrland packages
    hyprland = inputs.hyprland.packages.${prev.stdenv.hostPlatform.system}.hyprland;
    xdg-desktop-portal-hyprland = inputs.hyprland.packages.${prev.stdenv.hostPlatform.system}.hyprland;

    # Apply patches
    nix-output-monitor = prev.nix-output-monitor.overrideAttrs {
      patches = [../patches/nix-output-monitor-icons.patch];
    };
  };

  scripts = final: prev: {
    scripts = import ../scripts final.pkgs;
  };

  # Allow access to stable packages
  stable-packages = final: prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}

{pkgs, ...}: {
  imports = [
    ./git.nix
    ./nushell.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    bat # `cat` alternative for pretty printing files
    btop # Hardware usage profiler
    comma # `nix-shell` wrapper for quickly running things without installing them
    fd # `find` but better
    ffmpeg # Video editing tool
    stable.ffmpeg-normalize # Audio normalisation tool
    fzf # General purpose fuzzy finder
    nix-output-monitor # More detailed output for `nix-build` commands
    jq # JSON manipulation
    ripgrep # File `grep`ping tool
    tldr # Short summaries of commands
    vulkan-tools # Tools to aid Vulkan graphics API development and testing
    # https://github.com/NixOS/nixpkgs/issues/397271
    wineWowPackages.waylandFull # Windows compatibility layer
    winetricks
    linuxKernel.packages.linux_6_6.cpupower # Allows modifying cpu frequency mode

    (unp.override {extraBackends = [unrar p7zip];}) # Archive unpacking tool

    (import ./scripts/compile-shaders.nix {inherit pkgs;})
  ];

  programs = {
    carapace.enable = true; # Autofill tool for many commands
    zoxide.enable = true; # `cd` but better
  };
}

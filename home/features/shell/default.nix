{pkgs, ...}: {
  imports = [
    ./git.nix
    ./gitui.nix
    ./nushell.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    bat # `cat` alternative for pretty printing files
    btop # Hardware usage profiler
    comma # `nix-shell` wrapper for quickly running things without installing them
    fd # `find` but better
    ffmpeg # Video editing tool
    fzf # General purpose fuzzy finder
    nix-output-monitor # More detailed output for `nix-build` commands
    jq # JSON manipulation
    ripgrep # File `grep`ping tool
    tldr # Short summaries of commands
    vulkan-tools # Tools to aid Vulkan graphics API development and testing
    # https://github.com/NixOS/nixpkgs/issues/397271
    stable.wineWowPackages.waylandFull # Windows compatibility layer
    stable.winetricks

    (unp.override {extraBackends = [unrar-free p7zip];}) # Archive unpacking tool
  ];

  programs = {
    carapace.enable = true; # Autofill tool for many commands
    zoxide.enable = true; # `cd` but better
  };
}

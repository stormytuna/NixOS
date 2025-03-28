{
  config,
  lib,
  pkgs,
  ...
}: let
  wrapDefaultPackage = name: desc: (wrapCustomPackage name pkgs.${name} desc);
  wrapScriptPackage = name: desc: (wrapCustomPackage name pkgs.scripts.${name} desc);
  wrapCustomPackage = name: pkg: desc: {
    option = name;
    package = pkg;
    description = desc;
  };
  # TODO: Builds were failing so just made some packages use stable
  packages = [
    # Gaming
    (wrapDefaultPackage "boilr" "Use steam as generic game launcher")
    (wrapDefaultPackage "gamemode" "Optimisations")
    (wrapDefaultPackage "heroic" "Epic Games library")
    (wrapCustomPackage "lutris" pkgs.stable.lutris "Generic games library")
    (wrapDefaultPackage "prismlauncher" "Minecraft launcher")
    (wrapDefaultPackage "r2modman" "Thunderstore modloader, mostly for Unity games modded with BepInEx")
    (wrapDefaultPackage "sidequest" "VR headset sideloading software ")
    (wrapDefaultPackage "sgdboop" "Tool to apply assets automatically from SteamGridDB to Steam Library games")
    # CLI tools
    (wrapDefaultPackage "bat" "Alternative to cat for displaying code files")
    (wrapDefaultPackage "btop" "Functional alternative to htop")
    (wrapDefaultPackage "comma" "nix shell wrapper for quickly running commands without installing them")
    (wrapDefaultPackage "fd" "Modern alternative to find")
    (wrapDefaultPackage "ffmpeg" "CLI video editing tool")
    (wrapDefaultPackage "fzf" "General prupose fuzzy finder")
    (wrapDefaultPackage "nix-output-monitor" "Detailed tree output for nix builds")
    (wrapDefaultPackage "ripgrep" "Recursive directory searching tool")
    (wrapDefaultPackage "tldr" "Short summaries of popular commands")
    (wrapDefaultPackage "vulkan-tools" "Tools to aid Vulkan graphics API development and testing")
    (wrapCustomPackage "wine" pkgs.wineWowPackages.waylandFull "Windows compatibility layer")
    # Art programs
    (wrapDefaultPackage "aseprite" "Pixel art spriting software")
    (wrapDefaultPackage "inkscape" "Vector graphics editor")
    (wrapDefaultPackage "gimp" "")
    # Other programs
    (wrapDefaultPackage "bitwarden" "Password and secrets manager")
    (wrapDefaultPackage "pavucontrol" "PulseAudio Volume Control, GTK based volume mixer")
    (wrapDefaultPackage "qbittorrent" "Torrenting software")
    (wrapDefaultPackage "unityhub" "Game engine")
    # Custom scripts
    (wrapScriptPackage "gamescope-cleanup" "Cleans up after gamescope, allowing steam to properly register games as closed")
  ];
in
  (lib.foldl' lib.recursiveUpdate {} (lib.lists.forEach packages (p: {
    options.modules.programs.${p.option}.enable = lib.mkEnableOption p.description;
  })))
  // {
    config = lib.mkMerge (lib.lists.forEach packages (p:
      lib.mkIf (config.modules.programs.${p.option}.enable) {
        home.packages = [p.package];
      }));
  }

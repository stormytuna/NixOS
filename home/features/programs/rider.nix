{
  lib,
  pkgs,
  ...
}: let
  # See https://huantian.dev/blog/unity3d-rider-nixos/
  extraPath = with pkgs; [
    dotnetCorePackages.sdk_6_0
    dotnetPackages.Nuget
    mono
    msbuild
  ];
  extraLib = with pkgs; [];
  riderPkg = pkgs.jetbrains.rider.overrideAttrs (attrs: {
    postInstall =
      ''
        # Wrap rider with extra tools and libraries
        mv $out/bin/rider $out/bin/.rider-toolless
        makeWrapper $out/bin/.rider-toolless $out/bin/rider \
          --argv0 rider \
          --prefix PATH : "${lib.makeBinPath extraPath}" \
          --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath extraLib}"

        # Making Unity Rider plugin work!
        # The plugin expects the binary to be at /rider/bin/rider,
        # with bundled files at /rider/
        # It does this by going up two directories from the binary path
        # Our rider binary is at $out/bin/rider, so we need to link $out/rider/ to $out/
        shopt -s extglob
        ln -s $out/rider/!(bin) $out/
        shopt -u extglob
      ''
      + attrs.postInstall or "";
  });
in {
  home.packages = [riderPkg];

  home.file.".local/share/applications/jetbrains-rider.desktop".source = let
    desktopFile = pkgs.makeDesktopItem {
      name = "jetbrains-rider";
      desktopName = "Rider";
      exec = "\"${riderPkg}/bin/rider\"";
      icon = "rider";
      type = "Application";
      # Don't show desktop icon in search or run launcher
      extraConfig.NoDisplay = "true";
    };
  in "${desktopFile}/share/applications/jetbrains-rider.desktop";

  home.file.".ideavimrc".text = ''
    let mapleader = " "

    set clipboard=unnamedplus,unnamed,ideaput

    " search settings
    set hlsearch   " highlight search occurences
    set ignorecase " ignore case...
    set smartcase  " ..except when we start with uppercase
    set incsearch  " show search results while typing
    set wrapscan   " wrap around to start of file at end

    set scrolloff=10

    " plugins, see https://github.com/JetBrains/ideavim/wiki/IdeaVim%20Plugins
    set argtextobj
    set functiontextobj
    set highlightedyank
    set peekaboo
    set surround
    set which-key

    " fuzzy find mappings
    map <leader>ff <action>(com.mituuz.fuzzier.Fuzzier)
    map <leader>fg <action>(com.mituuz.fuzzier.FuzzyGrepCaseInsensitive)

    " other mappings
    map <leader>r <action>(RenameElement)
    nnoremap <ESC> :noh<CR><ESC>
    map U <C-R>
  '';
}

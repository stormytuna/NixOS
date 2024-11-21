{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./git.nix
    ./kitty.nix
    ./mangohud.nix
    ./minecraft-servers.nix
    ./neovim.nix
    ./nushell.nix
    ./packages.nix
    ./spotify.nix
    ./starship.nix
    ./thefuck.nix
    ./vesktop.nix
    ./waybar.nix
    ./wofi.nix
    ./zen-browser.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}

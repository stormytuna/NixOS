{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    github-desktop
    jetbrains.rider
    avalonia-ilspy
  ];
}

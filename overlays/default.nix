{
  outputs,
  inputs,
}: {
  additions = final: prev:
    import ../packages {pkgs = final;}
    // {
      hyprland = inputs.hyprland.packages.${inputs.pkgs.stdenv.hostPlatform.system}.hyprland;
      xdg-desktop-portal-hyprland = inputs.hyprland.packages.${inputs.pkgs.stdenv.hostPlatform.system}.hyprland;
    };
}

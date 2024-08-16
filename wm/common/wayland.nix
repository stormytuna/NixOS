{
  pkgs,
  systemSettings,
  ...
}: {
  imports = [
    ./fonts.nix
    ./gnome-keyring.nix
  ];

  environment.systemPackages = with pkgs; [
    wayland
  ];

  # Only applies to xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = systemSettings.keymap;
      #options = "caps:escape" # On current keyboard I'm just using hardware level remaps
    };
  };
}

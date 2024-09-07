{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [<home-manager/nixos>];

  options = {
    modules.desktop.gnome.enable = lib.mkEnableOption "Enables the gnome desktop environment";
  };

  config = lib.mkIf config.modules.desktop.gnome.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    services.pipewire.enable = lib.mkForce false;

    environment.systemPackages =
      (with pkgs; [
        gnome-tweaks
        dconf-editor
      ])
      ++ (with pkgs.gnomeExtensions; [
        # TODO: Find what extensions i want
        ddterm # Dropdown terminal
        switcher # Rofi-like application launcher
        #arc-menu # Similar thing to switcher, want to try this out at some point
        open-bar # More configurable top bar
        blur-my-shell # Blurs some elements
        gsnap # Kind-of tiling
      ]);

    home-manager.users.stormytuna.dconf = {
      enable = true;
      # TODO: Move imperative configs into here
    };
  };
}

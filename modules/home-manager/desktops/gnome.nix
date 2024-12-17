{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.desktops.gnome = {
    enable = lib.mkEnableOption "Gnome configuration";
  };

  # TODO: Commented out ones don't work on gnome 47, need to see if theyre up to date on github and fetch them manually if so
  config = lib.mkIf config.modules.desktops.gnome.enable {
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [
          "Vitals@CoreCoding.com"
          #"cronomix@zagortenay333"
          "ddterm@amezin.github.com"
          #"sermon@rovellipaolo-gmail.com"
          "space-bar@luchrioh"
          #"switcher@landau.fi"
          #"unmess@ezix.org"
          "wiggle@mechtifs"
          "status-icons@gmone-shell-extensions.gcampax.github.com"
          "launch-new-instance@gmone-shell-extensions.gcampax.github.com"
        ];
      };
    };

    home.packages = with pkgs.gnomeExtensions; [
      vitals # PC resource display
      #unmess # Assign applications to workspaces
      ddterm # Dropdown terminal
      #sermon # Service monitor
      #cronomix # Timer, stopwatch, alarms
      #switcher # Quick window switching
      space-bar # Replaces workspace bar with an i3-like one and has more workspace related QoL
      blur-my-shell # Nicer visuals for top bar and workspace background
      forge # Tiling windows
      #pano # Clipboard history manager
      just-perfection # Tweaking tool
    ];
  };
}

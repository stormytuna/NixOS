{pkgs, ...}: {
  programs.steam = {
    enable = true;
    protontricks.enable = true;

    extraCompatPackages = [pkgs.proton-ge-bin];

    # Allow online play
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}

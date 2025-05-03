{pkgs, ...}: {
  programs.steam = {
    enable = true;
    protontricks.enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
      gamescope
    ];

    # Allow online play
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}

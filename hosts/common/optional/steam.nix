{pkgs, ...}: {
  programs.steam = {
    enable = true;
    protontricks.enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    # Allow online play
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}

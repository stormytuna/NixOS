{pkgs-unstable, ...}: {
  services.syncthing = {
    enable = true;
    #package = pkgs-unstable.syncthing;
    extraFlags = ["--allow-newer-config"];
  };
}

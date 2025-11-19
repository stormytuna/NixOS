{...}: {
  services.syncthing = {
    enable = true;
    extraFlags = ["--allow-newer-config"];
  };
}

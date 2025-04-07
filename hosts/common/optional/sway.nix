{...}: {
  security.polkit.enable = true;
  programs.dconf.enable = true;

  # TODO: autologin, was using greetd before, could just port the module?
}

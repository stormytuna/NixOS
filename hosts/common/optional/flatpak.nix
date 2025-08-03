{...}: {
  services.flatpak = {
    enable = true;

    packages = [
      {
        appId = "app.zen_browser.zen";
        origin = "flathub";
      }
    ];
  };
}

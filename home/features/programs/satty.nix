{...}: {
  programs.satty = {
    enable = true;
    settings = {
      general = {
        early-exit = true;
        initial-tool = "brush";
        copy-command = "wl-copy";
        output-filename = "$XDG_PICTURES_DIR/screenshots/satty_%Y-%m-%d_%H-%M-%S).png";
        actions-on-enter = ["save-to-clipboard" "exit"];
        actions-on-escape = ["exit"];
      };
    };
  };
}

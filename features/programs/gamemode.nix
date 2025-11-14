{...}: {
  programs.gamemode = {
    enable = true;
    settings = {
      # WARN: GPU optimisations may damage hardware, use at your own risk!
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };
}

{pkgs, ...}: {
  programs.mangohud = {
    enable = true;
    package = pkgs.mangohud;
    enableSessionWide = true;
  };

  # Not using `programs.mangohud.settings` as it reorders our attribute set, but order is important in our config
  # See here for options: https://github.com/flightlessmango/MangoHud/blob/master/data/MangoHud.conf
  home.file.".config/MangoHud/MangoHud.conf".text = ''
    legacy_layout=false

    background_alpha=0.3
    round_corners=0
    background_alpha=0.7
    background_color=000000

    font_size=26
    text_color=FFFFFF
    position=top-left
    toggle_hud=F7
    pci_dev=0:03:00.0
    table_columns=3

    gpu_text=GPU
    gpu_stats
    gpu_temp
    gpu_mem_temp

    cpu_text=CPU
    cpu_stats
    cpu_temp

    io_read
    io_write

    vram
    vram_color=AD64C1

    ram
    ram_color=C26693

    fps
    gpu_name
    vulkan_driver
    frame_timing
    frametime_color=00FF00
    fps_limit_method=late
    toggle_fps_limit=Shift_L+F1
    show_fps_limit
    histogram
    fps_limit=0
    resolution
    fsr
    hdr
    gamemode

    log_duration=30
    autostart_log=0
    log_interval=100
    toggle_logging=Shift_L+F2

    no_display
  '';
}

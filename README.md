# My NixOS Configuration

This is the [NixOS](https://nixos.org/) configuration that powers my personal PC (eva-unit-01) and my work laptop (eva-unit-02). See [my dotfiles](https://github.com/stormytuna/Dotfiles) for the configuration side of things and a more detailed explanation of why I use what I use.

I use NixOS instead of other solutions as it's the easiest to tinker with without breaking stuff. If I want to use KDE Plasma this week, I can simply enable it, and when I decide it's rubbish, I can simply disable it. No faffing about with system files. It also has **the** largest package manager, and supports declaring your own packages (not that I have done that much). I strongly recommend NixOS if you can overlook its quirks.

## Organisation

- `features` contains chunks of Nix configuration to be reused across multiple hosts
- `hosts` contains machine-specific configuration
- `users` contains user configuration to be reused across multiple hosts

{ systemSettings, ... }:

{
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true; # Easier to use than alternative
}

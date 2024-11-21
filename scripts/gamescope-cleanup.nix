{pkgs}:
pkgs.writeShellScriptBin "gamescope-cleanup" ''
  pkill -9 wine & pkill -9 wineserver & pkill -9 winedevice.exe & pkill -9 explorer.exe & pkill -9 gamescope-wl
''

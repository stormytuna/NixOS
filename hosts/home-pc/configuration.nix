{
  pkgs,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    ../../home.nix
    ./hardware-configuration.nix
    (../../. + "/wm/${userSettings.wm}/${userSettings.wm}.nix") # TODO: Proper modules!
    ../../apps/apps.nix
    ../../dev/dev.nix
    ../../hardware/hardware.nix
    ../../shell/shell.nix
    ../../style/style.nix
  ];

  # Configure bootloader
  # Uses systemd-boot if uefi, grub otherwise
  boot.loader.systemd-boot.enable = systemSettings.bootMode == "uefi";
  boot.loader.efi.canTouchEfiVariables = systemSettings.bootMode == "uefi";
  boot.loader.efi.efiSysMountPoint = systemSettings.bootMountPath; # Does nothing if we're using grub
  boot.loader.grub.enable = systemSettings.bootMode != "uefi";
  boot.loader.grub.device = systemSettings.grubDevice; # Does nothing if we're using uefi

  # Remove need to type in password for sudo commands
  security.sudo.extraRules = [
    {
      users = ["stormytuna"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  # Select internationalisation properties.
  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # Configure tty keymap
  console.keyMap = systemSettings.consoleKeymap;

  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable `sudo`
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Leave this unchanged for compatibility purposes
  system.stateVersion = "23.11";
}

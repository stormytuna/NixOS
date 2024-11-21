{
  config,
  lib,
  ...
}: {
  options.modules.programs.thefuck = {
    enable = lib.mkEnableOption "Fixes common mistakes in CLI commands";
  };

  config = lib.mkIf config.modules.programs.thefuck.enable {
    programs.thefuck = {
      enable = true;
      enableZshIntegration = config.modules.programs.zsh.enable;
      enableNushellIntegration = config.modules.programs.nushell.enable;
    };
  };
}

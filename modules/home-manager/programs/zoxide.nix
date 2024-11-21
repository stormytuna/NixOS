{
  config,
  lib,
  ...
}: {
  options.modules.programs.zoxide = {
    enable = lib.mkEnableOption "modern cd alternative";
  };

  config = lib.mkIf config.modules.programs.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = config.modules.programs.zsh.enable;
      enableNushellIntegration = config.modules.programs.nushell.enable;
    };
  };
}

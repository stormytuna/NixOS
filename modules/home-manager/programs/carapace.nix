{
  config,
  lib,
  ...
}: {
  options.modules.programs.carapace = {
    enable = lib.mkEnableOption "Shell completion library";
  };

  config = lib.mkIf config.modules.programs.carapace.enable {
    programs.carapace = {
      enable = true;
      enableZshIntegration = config.modules.programs.zsh.enable;
      enableNushellIntegration = config.modules.programs.nushell.enable;
    };
  };
}

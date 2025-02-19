{
  config,
  lib,
  ...
}: {
  options.modules.programs.librewolf = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.modules.programs.librewolf.enable {
    programs.librewolf = {
      enable = true;
      settings = {
      };
    };
  };
}

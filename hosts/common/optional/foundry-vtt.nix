{
  pkgs,
  inputs,
  ...
}: {
  services.foundryvtt = {
    enable = true;
    package = inputs.foundry-vtt.packages.${pkgs.system}.foundryvtt_13;
  };
}

{
  pkgs,
  inputs,
  ...
}: {
  services.foundryvtt = {
    enable = true;
    package = inputs.foundry-vtt.packages.${pkgs.stdenv.hostPlatform.system}.foundryvtt_13;
  };
}

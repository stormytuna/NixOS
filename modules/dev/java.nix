{pkgs, ...}: {
  environment.systemPackages = with pkgs; [jdk22 jre8];
}

{pkgs, ...}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      rocmPackages.clr.icd # Required for davinci resolve
    ];
  };
}

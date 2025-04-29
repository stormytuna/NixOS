{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "modern-minimal-ui-sounds.nix";
  src = pkgs.fetchFromGitHub {
    owner = "cadecomposer";
    repo = "modern-minimal-ui-sounds";
    rev = "09029039f64cfd2e50df2f84d657e93a24b3eb3a";
    sha256 = "sha256-bjltipCUUQdNBLb2CYoxM/dIPCDvA+bloHpMNYsH6LM=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./stereo ./index.theme $out/
  '';
}

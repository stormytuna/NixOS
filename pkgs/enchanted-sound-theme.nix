{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "enchanted-sound-theme.nix";
  src = pkgs.fetchFromGitHub {
    owner = "rtlewis88";
    repo = "rtl88-Themes";
    rev = "202f7f5d680d4632e2de97eb532fd6b3202019b6";
    sha256 = "sha256-zOtaZLXZ+U+ZhQcjSeBy3uM3t+ruoe5udxhN9KwrzuQ=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./Enchanted/* $out/
  '';
}

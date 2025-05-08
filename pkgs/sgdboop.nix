{pkgs}:
pkgs.stdenv.mkDerivation rec {
  name = "sgdboop";
  version = "1.3.1";
  src = pkgs.fetchurl {
    url = "https://github.com/SteamGridDB/SGDBoop/releases/download/v${version}/sgdboop-linux64.tar.gz";
    sha256 = "sha256-NRP5b/Idpiq54bAFNsNcsfNXECgqLp2i/lys0fqsLUo=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [pkgs.autoPatchelfHook];

  buildInputs = with pkgs; [openssl curl gtk3 gdk-pixbuf glib pango cairo];

  installPhase = ''
    runHook preInstall
    install -m755 -D SGDBoop $out/bin/SGDBoop
    install -m444 -D com.steamgriddb.SGDBoop.desktop -t $out/share/applications/
    runHook postInstall
  '';
}

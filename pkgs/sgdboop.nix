{pkgs}:
pkgs.stdenv.mkDerivation rec {
  name = "sgdboop.nix";
  version = "1.2.8";
  src = pkgs.fetchurl {
    url = "https://github.com/SteamGridDB/SGDBoop/releases/download/v${version}/sgdboop-linux64.tar.gz";
    sha256 = "sha256-LrP0qFg4kOhAicWtORfnW3TvIegvcJf/GiYTHcOeJK4=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [pkgs.autoPatchelfHook];

  buildInputs = with pkgs; [openssl curl gtk3 gdk-pixbuf glib pango cairo];

  installPhase = ''
    runHook preInstall
    install -m755 -D SGDBoop $out/bin/SGDBoop
    install -m444 -D libiup.so $out/lib/libiup.so
    install -m444 -D com.steamgriddb.SGDBoop.desktop -t $out/share/applications/
    runHook postInstall
  '';
}

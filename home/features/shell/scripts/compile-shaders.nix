{pkgs}:
pkgs.writeShellScriptBin "compile-shaders" ''
  for inFile in *.fx; do
    outFile="''${inFile%.fx}.fxc"

    if [[ ! -f "$outFile" || "$inFile" -nt "$outFile" ]]; then
      wine ~/ws/fxc/fxc.exe /T fx_2_0 /nologo "$inFile" /Fo "$outFile"
    fi
  done
''

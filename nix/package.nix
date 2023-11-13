{ lib, stdenv }:

stdenv.mkDerivation rec {
  name = "pp-to-amd-epp";
  unpackPhase = ":";
  installPhase = "install -m755 -D ${../pp-to-amd-epp} $out/bin/pp-to-amd-epp";
}



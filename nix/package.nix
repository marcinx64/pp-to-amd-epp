{ lib, stdenv, pkgs }:

stdenv.mkDerivation rec {
  name = "pp-to-amd-epp";

  propagatedBuildInputs = [ pkgs.power-profiles-daemon pkgs.python3 ];
  unpackPhase = ":";
  installPhase = "install -m755 -D ${../pp-to-amd-epp} $out/bin/pp-to-amd-epp";

  meta = {
    description = "Power Profiles Daemon to AMD P-STATE EPP";
    mainProgram = "pp-to-amd-epp";
  };

}



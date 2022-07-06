{
  nixpkgs,
  lib,
}: {
  name,
  paths ? [],
}: let
  cpPackages = lib.concatStringsSep "\n" (map (f: let name = f.pname or f.name; in "ln -s ${f} $out/${name}") paths);
  inherit paths;
  bin = nixpkgs.symlinkJoin {
    inherit paths;
    name = "bin";
  };
in
  nixpkgs.runCommand name {
    buildInputs = [];
  } ''
     mkdir -p $out
     ln -s ${bin}/bin $out
    ${cpPackages}
  ''

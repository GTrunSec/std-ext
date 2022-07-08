{
  nixpkgs,
  lib,
}: {
  name,
  paths ? [],
}: let
  drvIsDir = path: builtins.pathExists ((toString path) + "/bin");
  drvIsFile = path: builtins.pathExists path && ! (drvIsDir path);

  cpPackages = lib.concatStringsSep "\n" (map (f: let name = f.pname or f.name; in "ln -s ${f} $out/${name}") paths);
  onlyPathsDir = lib.flatten (map (f: lib.optionals (drvIsDir f) f) paths);

  bin = nixpkgs.symlinkJoin {
    paths = onlyPathsDir;
    name = "bin-links";
  };
in
  nixpkgs.runCommand name {
    buildInputs = [];
  } ''
    mkdir -p $out
    ln -s ${bin}/bin $out
    ${cpPackages}
  ''

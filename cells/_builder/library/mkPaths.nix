{
  inputs,
  cell
}: {
  name,
  paths ? [],
}:let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs) nixpkgs;

  isDir = path: builtins.pathExists ((toString path) + "/bin");

  cpPackages = lib.concatStringsSep "\n" (map (f: let name = f.pname or f.name; in "ln -s ${f} $out/${name}") paths);
  onlyPathsDir = lib.flatten (map (f: lib.optionals (isDir f) f) paths);

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

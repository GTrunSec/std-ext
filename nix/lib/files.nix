{
  inputs,
  cell,
}: let
  l = inputs.nixlib.lib // builtins;
  inherit
    (builtins)
    isPath
    pathExists
    toString
    ;
in rec {
  # isDir:: path -> bool
  #
  # A filesystem trick is used.
  #
  isDir = path: pathExists ((toString path) + "/.");

  # isFile :: path -> bool
  #
  # Symlinks are dirs or files ultimately.
  #
  # isFile = x: builtins.match ".*[.][[:alnum:]]+$" (builtins.baseNameOf x) == [];
  isFile = path: isPath path && pathExists path && ! (isDir path);

  filterFiles = path: ext: let
    a = key: value:
      value
      == "regular"
      && l.hasSuffix ".${ext}" key
      && key != "default.nix";
  in
    l.filterAttrs a (builtins.readDir path);
}

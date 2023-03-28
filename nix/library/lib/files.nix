{lib}: let
  inherit
    (lib)
    hasSuffix
    filterAttrs
    ;

  inherit
    (builtins)
    isPath
    pathExists
    toString
    ;

  inherit (lib.path) isDir;
in rec {
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
      && hasSuffix ".${ext}" key
      && key != "default.nix";
  in
    filterAttrs a (builtins.readDir path);
}

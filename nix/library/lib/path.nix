{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs // builtins // cell.files;
  inherit (l) isDir;

  inherit
    (builtins)
    attrNames
    concatMap
    readDir
    ;

  inherit
    (cell.attrsets)
    getAttrsByValue
    ;

  # _listDirs :: path -> [ path ]
  #
  # It saves 1-2ms magically compared to calling
  # "nuran.path.path.listDirs" (both with
  # type checking disabled).
  #
  _listDirs = toplevel: let
    dirs = getAttrsByValue "directory" (readDir toplevel);
  in
    map (name: toplevel + "/${name}") (attrNames dirs);

  # _listAllDirs :: path -> [ path ]
  #
  # Raw "listAllDirs" without type checking
  # to increase the speed.
  #
  _listAllDirs = toplevel: let
    subdirs = _listDirs toplevel;
  in
    if subdirs == []
    then [toplevel]
    else [toplevel] ++ (concatMap _listAllDirs subdirs);
in {
  mkPaths = import ./path/mkPaths.nix {inherit inputs cell;};
  # listAllDirs :: path -> [ path ]
  #
  # Traverse the $toplevel from up to bottom
  # and find every directories under it.
  #
  listAllDirs = toplevel:
    assert isDir toplevel;
      _listAllDirs toplevel;

  # listAllFiles :: path -> [ path ]
  #
  # Walk through $toplevel and list every regular files.
  #
  listAllFiles = toplevel:
    assert isDir toplevel;
      l.filesystem.listFilesRecursive toplevel;
}

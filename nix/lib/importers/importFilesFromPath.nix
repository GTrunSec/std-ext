{
  lib,
  pathsToImportedAttrs,
}: let
  filesToList = dir: suffix: let
    fullPath = name: dir + "/${name}";
  in
    map fullPath (lib.attrNames (lib.filterFiles dir suffix));
in
  path: ext: lib.attrValues (pathsToImportedAttrs (filesToList path ext))

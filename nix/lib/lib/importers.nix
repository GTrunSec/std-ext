{
  inputs,
  cell,
}: {
  importNixFilesFromPath = import ./importers/importNixFilesFromPath.nix {
    lib = inputs.nixpkgs.lib;
    inherit (cell.attrsets) pathsToImportedAttrs;
  };
}

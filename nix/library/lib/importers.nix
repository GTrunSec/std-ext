{
  inputs,
  cell,
}: {
  importNixFilesFromPath = import ./importers/importNixFilesFromPath.nix {
    inherit (inputs.nixpkgs) lib;
    inherit (cell.attrsets) pathsToImportedAttrs;
  };
}

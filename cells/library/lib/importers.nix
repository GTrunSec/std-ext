{ lib }:
{
  importNixFilesFromPath = import ./importers/importNixFilesFromPath.nix {
    inherit lib;
  };
}

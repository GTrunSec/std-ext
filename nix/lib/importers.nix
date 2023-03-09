{
  inputs,
  cell,
}: {
  importNixFilesFromPath = import ./importers/importNixFilesFromPath.nix {lib = inputs.nixpkgs.lib // inputs.xnlib.lib;};
}

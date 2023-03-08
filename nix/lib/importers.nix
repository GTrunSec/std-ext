{
  inputs,
  cell,
}: {
  importNixFilesFromPath = import ./importers/importNixFilesFromPath.nix {lib = inputs.nixlib.lib // inputs.xnlib.lib;};
}

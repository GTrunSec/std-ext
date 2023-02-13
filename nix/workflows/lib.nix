{
  inputs,
  cell,
} @ args: {
  mkCargoMake = import ./mkCargoMake.nix args;
  mkProcessCompose = import ./mkProcessCompose.nix {inherit inputs;};
  mkSingle = import ./mkSingle.nix {inherit inputs;};
}

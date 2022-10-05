{
  inputs,
  cell,
} @ args: {
  makeCargoMakeFlow = _args: (import ./makekCargoMakeFlow.nix args) _args;
}

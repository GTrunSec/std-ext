{
  inputs,
  cell,
} @ args: {
  default = import ./main.nix args;
  docs = import ./docs.nix;
}

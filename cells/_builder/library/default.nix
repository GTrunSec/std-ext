{
  inputs,
  cell,
}@args: let
in {
  mkPaths = import ./mkPaths.nix args;
}

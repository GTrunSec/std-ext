{
  inputs,
  cell,
} @ args: let
  microvm = _args: import ./microvms.nix _args;
  makeVM = _args: import ./makeVM.nix args _args;
in {
  inherit
    makeVM
    microvm
    ;
}

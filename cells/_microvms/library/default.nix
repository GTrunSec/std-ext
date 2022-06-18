{
  inputs,
  cell,
} @ args: let
  makeVM = _args: import ./makeVM.nix args _args;
in {
  inherit
    makeVM
    ;
}

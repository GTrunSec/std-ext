{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__;
  inherit (__inputs__) nickel;
in {
  nickel = nickel.packages.build;
}

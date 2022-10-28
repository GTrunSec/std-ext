{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) __inputs__;
  inherit (__inputs__) nickel;
in {
  nickel = nickel.packages.build;
}

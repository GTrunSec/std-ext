{
  inputs,
  cell,
}: let
  inherit (inputs) nickel;
in {
  nickel = nickel.packages.build;
}

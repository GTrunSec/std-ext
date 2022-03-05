{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs nickel;
in {
  nickel = nickel.packages.build;
}

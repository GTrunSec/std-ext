{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells.makes.library) __output__ makeSubstitution;
in {}

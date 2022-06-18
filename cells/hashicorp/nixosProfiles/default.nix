{
  inputs,
  cell,
}: let
  inherit (cell) packages;
in {
  nomad = ./nomad.nix;
}

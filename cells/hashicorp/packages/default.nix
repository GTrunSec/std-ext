{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs nomad;
in {
  inherit
    (nomad.packages)
    nomad
    ;
}

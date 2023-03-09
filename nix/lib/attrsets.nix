{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;
in
  import ./attrsets {inherit l;}

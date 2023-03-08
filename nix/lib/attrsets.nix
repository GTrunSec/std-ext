{
  inputs,
  cell,
}: let
  l = inputs.nixlib.lib // builtins;
in
  import ./attrsets {inherit l;}

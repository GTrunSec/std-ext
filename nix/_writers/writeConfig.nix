{
  inputs,
  cell,
}: name: format: attr: let
  inherit (cell) lib;
  inherit (inputs) nixpkgs;
in
  (nixpkgs.formats."${format}" {}).generate "${name}" attr

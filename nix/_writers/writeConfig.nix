{
  inputs,
  cell,
}: name: format: attr: let
  inherit (cell) library;
  inherit (inputs) nixpkgs;
in
  (nixpkgs.formats."${format}" {}).generate "${name}" attr

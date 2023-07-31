{ inputs, cell }:
name: attr:
let
  inherit (cell) lib;
  inherit (inputs) nixpkgs;
  l = inputs.nixpkgs.lib // builtins;
  getFormat = l.last (l.splitString "." name);
in
(nixpkgs.formats."${getFormat}" { }).generate "${name}" attr

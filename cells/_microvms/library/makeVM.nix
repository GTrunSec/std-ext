{
  inputs,
  cell,
}: {
  module,
  channel ? inputs.nixpkgs,
}: let
  inherit (cell) library;
  channels = {
    nixpkgs = channel;
    inherit (inputs) microvm;
  };
  microvm = cell.library.microvm channels;
in
  microvm module

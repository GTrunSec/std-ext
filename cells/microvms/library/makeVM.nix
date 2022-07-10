{
  inputs,
  cell,
}: {
  module,
  channel ? inputs.nixpkgs,
}: let
  inherit (cell) library;
  inherit (inputs.cells.main.library) __inputs__;
  channels = {
    nixpkgs = channel;
    inherit (__inputs__) microvm;
  };
  microvm = cell.library.microvm channels;
in
  microvm module

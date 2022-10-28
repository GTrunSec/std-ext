{
  inputs,
  cell,
}: {
  module,
  channel ? inputs.nixpkgs,
}: let
  inherit (cell) lib;
  inherit (inputs.cells.common.lib) __inputs__;
  channels = {
    nixpkgs = channel;
    inherit (__inputs__) microvm;
  };
  microvm = cell.lib.microvm channels;
in
  microvm module

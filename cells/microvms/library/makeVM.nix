{
  inputs,
  cell,
}: {
  module,
  channel ? inputs.nixpkgs,
}: let
  inherit (cell) library;
  inherit (inputs.cells.main.library) inputs';
  channels = {
    nixpkgs = channel;
    inherit (inputs') microvm;
  };
  microvm = cell.library.microvm channels;
in
  microvm module

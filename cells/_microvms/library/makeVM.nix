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
  microvm = inputs.std-microvm.std.lib.fromMicrovmWith channels;
in
  microvm module

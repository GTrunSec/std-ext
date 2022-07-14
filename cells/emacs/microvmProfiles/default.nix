{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.library) __inputs__;
  microvm = inputs.std.std.lib.fromMicrovmWith __inputs__;
in {
  inherit (inputs) nixpkgs;
  task = microvm ({
    pkgs,
    lib,
    ...
  }: {networking.hostName = "microvms-host";});
}

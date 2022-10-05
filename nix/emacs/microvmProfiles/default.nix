{
  inputs,
  cell,
}: let
  inherit (inputs.cells.main.lib) __inputs__;
  microvm = __inputs__.std.lib.ops.mkMicrovm;
in {
  inherit (inputs) nixpkgs;
  task = microvm ({
    pkgs,
    lib,
    ...
  }: {networking.hostName = "microvms-host";});
}

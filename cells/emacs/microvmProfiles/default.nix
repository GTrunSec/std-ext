{
  inputs,
  cell,
}: let
  microvm = inputs.std-microvm.std.lib.fromMicrovmWith inputs;
in {
  inherit (inputs) nixpkgs;
  task = microvm ({
    pkgs,
    lib,
    ...
  }: {networking.hostName = "microvms-host";});
}

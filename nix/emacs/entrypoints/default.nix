{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.lib) writeShellApplication;
  inherit (inputs) nixpkgs;
in {
  test = cell.microvmProfiles.task.config.microvm.runner.qemu;
}

{
  inputs,
  cell,
}: let
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs) nixpkgs;
in {
  test = cell.microvmProfiles.test.config.microvm.runner.qemu;
}

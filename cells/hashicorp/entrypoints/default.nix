{
  inputs,
  cell,
}: let
  inherit (cell) nixosProfiles;
in {
  vm-dev = nixosProfiles.cluster-dev.config.microvm.runner.qemu;
}

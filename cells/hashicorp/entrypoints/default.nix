{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs spongix nomad-driver-nix;
  inherit (cell) packages nixosProfiles;
  inherit (inputs.cells._writers.library) writeShellApplication;
in {
  vm-dev = nixosProfiles.cluster-dev.config.microvm.runner.qemu;
}

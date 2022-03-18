{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  inherit (inputs.cells._writers.library) writeShellApplication;
in {
  socProfiles = {
    openCTI ? false,
    MISP ? false,
    zeek ? false,
    suricata ? false,
    branch ? ["prod" "develop" "CI"],
    target ? ["k8s" "nomad" "docker"],
  }: {
  };
}

{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs dockerJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile makeConfiguration;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells.makes.library) makeSubstitution;

  name = "opencti-nomad-container";

  common = branch:
    makeConfiguration {
      inherit name;
      target = "nomad";
      inherit branch;
      source = nomadJobs.container {
        driver = "podman";
      };
      format = "json";
    };
in {
  dev = common "dev";
}

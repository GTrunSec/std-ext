{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells._templates.library) makeTemplate;
in {
  elasticsearch-nomad-container = makeTemplate {
    name = "elasticsearch-nomad-container-dev";
    target = "nomad";
    source =
      nixpkgs.lib.recursiveUpdate (nomadJobs.elasticsearch {
        driver = "podman";
      }) {
        job.elasticsearch = (nomadJobs.kibana {driver = "podman";}).job.elasticsearch;
      };
    format = "json";
  };
}

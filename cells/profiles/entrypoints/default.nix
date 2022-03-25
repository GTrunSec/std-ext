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
  nomad-container-elasticsearch-dev = makeTemplate {
    name = "nomad-container-elasticsearch-dev";
    target = "nomad";
    source =
      nixpkgs.lib.recursiveUpdate (nomadJobs.elasticsearch {
        driver = "podman";
      }) {
        job.elasticsearch = (nomadJobs.kibana {driver = "podman";}).job.elasticsearch;
      };
    format = "json";
  };

  nomad-nixos-airflow = makeTemplate {
    name = "nomad-nixos-airflow";
    target = "nomad";
    source = nomadJobs.nixos-airflow {
      flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-airflow";
    };
    format = "json";
  };
}

{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile makeConfiguration;
  inherit (inputs.cells._writers.library) writeShellApplication;
in {
  nomad-container-elasticsearch-dev = makeConfiguration {
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

  nomad-nixos-airflow = makeConfiguration {
    name = "nomad-nixos-airflow";
    target = "nomad";
    source = nomadJobs.nixos-airflow {
      flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-airflow";
    };
    format = "json";
  };
}

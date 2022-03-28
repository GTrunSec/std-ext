{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs dockerJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells._templates.library) makeTemplate;
in {
  nomad-container = makeTemplate {
    name = "opencti-nomad-container-dev";
    target = "nomad";
    source = nomadJobs.container {
      driver = "podman";
    };
    format = "json";
  };
  nomad-hydration = makeTemplate {
    name = "opencti-nomad-hydration-dev";
    target = "nomad";
    source = nomadJobs.container {
      driver = "podman";
    };
    format = "json";
  };

  nomad-nixos-dev = makeTemplate {
    name = "opencti-nomad-nixos-dev";
    target = "nomad";
    source = nomadJobs.nixos-node {
      flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-tenzir-opencti";
    };
    format = "json";
  };

  docker-compose = makeTemplate {
    name = "opencti-docker-compose-prod";
    target = "docker-compose";
    source = dockerJobs.compose {};
    format = "yaml";
  };
}

{
  inputs,
  cell,
} @ args: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs dockerJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile makeConfiguration;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells.makes.library) makeSubstitution;
in {
  nomad-container = makeConfiguration {
    name = "opencti-nomad-container-dev";
    target = "nomad";
    source = nomadJobs.container {
      driver = "podman";
    };
    format = "json";
  };
  nomad-hydration = makeConfiguration {
    name = "opencti-nomad-hydration-dev";
    target = "nomad";
    source = nomadJobs.container {
      driver = "podman";
    };
    format = "json";
  };

  nomad-nixos-dev = makeConfiguration {
    name = "opencti-nomad-nixos-dev";
    target = "nomad";
    source = nomadJobs.nixos-node {
      flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-tenzir-opencti";
    };
    format = "json";
  };

  docker-compose-prod = import ./docker-compose-prod.nix args;
}

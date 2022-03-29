{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs dockerJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile makeConfiguration;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells.makes.library) makeSubstitution;

  name = builtins.baseNameOf ./.;

  common = branch:
    makeConfiguration {
      inherit name;
      target = "nomad";
      source = nomadJobs.nixos-airflow {
        flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-airflow";
      };
      inherit branch;
      format = "json";
    };
in {
  dev = common "dev";
}

{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs.cells._modules.library) makeConfiguration;

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

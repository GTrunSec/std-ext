{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs.cells._modules.library) makeConfiguration;

  name = builtins.baseNameOf ./.;

  common = {
    branch,
    source,
  }:
    makeConfiguration {
      inherit name source branch;
      target = "nomad";
      format = "json";
    };
in {
  dev = common {
    branch = "dev";
    source = nomadJobs.nixos.airflow {
      flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-airflow";
    };
  };
  prod = common {
    branch = "prod";
    source = nomadJobs.nixos.airflow {
      flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-airflow";
    };
  };
}

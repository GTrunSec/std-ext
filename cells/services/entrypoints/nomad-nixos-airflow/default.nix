{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs) nixpkgs self;
  inherit (inputs.cells._modules.library) makeConfiguration;

  name = builtins.baseNameOf ./.;

  common = branch: source:
    makeConfiguration {
      inherit name source branch;
      target = "nomad";
      format = "json";
    };
in {
  dev = common "dev" nomadJobs.nixos.airflow {
    flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-airflow";
  };
  prod = common "prod" nomadJobs.nixos.airflow {
    flake = "${self.outPath}#${nixpkgs.system}.tenzir.nixosProfiles.nomad-airflow";
  };
}

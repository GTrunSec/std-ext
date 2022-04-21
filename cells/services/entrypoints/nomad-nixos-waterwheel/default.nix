{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs nixosProfiles;
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
  dev = common "dev" (nomadJobs.nixos.waterwheel {
    # flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-airflow";
    flake = "${self.outPath}#${nixpkgs.system}.services.nixosProfiles.nomad-waterwheel-dev";
  });
  prod = common "prod" (nomadJobs.nixos.airflow {
    flake = "${self.outPath}#${nixpkgs.system}.tenzir.nixosProfiles.nomad-waterwheel";
  });
}

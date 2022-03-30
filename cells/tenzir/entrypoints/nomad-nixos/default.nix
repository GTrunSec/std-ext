{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self;
  inherit (cell) nomadJobs;
  inherit (inputs.cells._modules.library) makeConfiguration;

  name = "tenzir-" + builtins.baseNameOf ./.;

  common = branch: source:
    makeConfiguration {
      inherit name;
      target = "nomad";
      inherit branch;
      source = nomadJobs.vast-nixos-node {
        flake = source;
      };
      format = "json";
    };

  prod = nomadJobs.vast-nixos-node {
    flake = "${self.outPath}#${nixpkgs.system}.tenzir.nixosProfiles.nomad-tenzir-vast";
  };

  dev = nomadJobs.vast-nixos-node {
    flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-opencti";
  };
in {
  opencti.dev = common "dev" dev;
  prod = common "prod" prod;
}

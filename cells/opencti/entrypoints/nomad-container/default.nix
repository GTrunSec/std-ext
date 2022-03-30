{
  inputs,
  cell,
}: let
  inherit (cell) nomadJobs;
  inherit (inputs.cells._modules.library) makeConfiguration;

  name = "opencti-nomad-nixos";

  common = branch:
    makeConfiguration {
      inherit name;
      target = "nomad";
      source = nomadJobs.nixos-node {
        flake = "/home/gtrun/ghq/github.com/GTrunSec/lambda-microvm-hunting-lab#nixosConfigurations.nomad-tenzir-opencti";
      };
      format = "json";
      inherit branch;
    };
in {
  dev = common "dev";
  hydration.dev = common "dev" // {};
}

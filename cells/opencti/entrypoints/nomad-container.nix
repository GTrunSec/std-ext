{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs self data-merge;
  inherit (cell) nomadJobs dockerJobs generator library nixosProfiles;
  inherit (inputs.cells._modules.library) makeSocProfile makeConfiguration;
  inherit (inputs.cells._writers.library) writeShellApplication;
  inherit (inputs.cells.makes.library) makeSubstitution;

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
